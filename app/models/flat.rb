class Flat < ApplicationRecord
  mount_uploaders :photos, FlatPhotosUploader
  # serialize :photos, JSON
  enum flat_type: [:Studio, :T1, :T2, :T3, :T4]

  belongs_to :user
  has_many :rentals, dependent: :destroy

  validates :address, presence: true

  geocoded_by :address
  reverse_geocoded_by :latitude, :longitude do |flat, results|
    if geo = results.first
      flat.city = geo.city
    end
  end

  validate :found_address_presence?
  after_validation :geocode#, :reverse_geocode
  before_save :reverse_geocode
  # before_save :define_city

  # def define_city
  #   return unless city.present?
  #   geocoded_adress = Geocoder.search("#{self.latitude}, #{self.longitude}")[0].data["address"]
  #   geocoded_city = geocoded_adress["city"]
  #   geocoded_town = geocoded_adress["town"]
  #   (geocoded_city != nil) ? self.city = geocoded_city : self.city = geocoded_town
  # end

  def found_address_presence?
    # Impossible de raise des flashes d'erreurs ici, donc cette methode renvoie une 500 si ladresse n'est pas géocodable. A ameliorer
    if self.geocode == nil || self.geocode[1] == nil
      errors.add(:address, "Cette addresse n'est pas valide, merci de la compléter.")
    end
  end

  def self.import(file)
    csv_options = { col_sep: ';', quote_char: '"', headers: :first_row }
    # knowing the ligne in the csv so we can send errors
    line = 1
    # storing the numbers of new flats for already existing users
    already_existing_users = Hash.new
    # sotring the flats that couldnt be created
    failed_flat_creations = []
    failed_user_creations = []

    CSV.foreach(file.path, csv_options) do |row|
      # Creating or finding the owner
      if User.find_by(email: row[2])
        # User already existed : creating his related flat
        existing_user = User.find_by(email: row[2])
        flat_infos = {user: existing_user,
                      address: row[13],
                      flat_type: "T1",
                      description: "Parking: #{row[6] ? row[6] : " : non communiqué"}\nLinge fourni: #{row[8] ? row[8] : " : non communiqué"}\nRemise des clés: #{row[10] ? row[10] : " : non communiqué"}\nHôpital le plus proche#{row[7] ? row[7] : " : non communiqué"}",
                      }
        # Flat can be created?
        if Flat.create(flat_infos)
          # Yes: count the number of new flats for an already existing user
          already_existing_users[existing_user.email] ? already_existing_users[existing_user.email] += 1 : already_existing_users[existing_user.email] = 1
        else
          # No: store the flat (line, owner name and address) that failed
          failed_flat_creations << [line, "erreur: l'appartement semble avoir une addresse inconnue"]
        end
      else
        # User didn't exist: creating the user(owner) and his related first flat
        random_password = (('0'..'9').to_a + ('A'..'Z').to_a + ('a'..'z').to_a).shuffle.first(6).join
        user_infos = {last_name: row[0] ? row[0].downcase.capitalize : nil,
                      first_name: row[1] ? row[1].downcase.capitalize : nil,
                      phone: row[3],
                      email: row[2],
                      password: random_password,
                      from_csv: true,
                      role: "owner",
                      rgpd: true
                      }
        # Can we create the user?
        if new_user = User.create(user_infos)
          # Yes : Create his related flat
          flat_infos = {user: new_user,
                        address: row[13],
                        flat_type: "T1",
                        description: "Parking: #{row[6] ? row[6] : " : non communiqué"}\nLinge fourni: #{row[8] ? row[8] : " : non communiqué"}\nRemise des clés: #{row[10] ? row[10] : " : non communiqué"}\nHôpital le plus proche#{row[7] ? row[7] : " : non communiqué"}",
                        }
          # Flat can be created?
          if Flat.create(flat_infos)
            # Yes: Send an email to the new owner with his password
            UserMailer.send_password_to_new_user(new_user, random_password)
          else
            # No: store the flat (line, owner name and address) that failed
            failed_flat_creations << [line, "erreur: l'appartement semble avoir une addresse inconnue"]
            new_user.destroy
          end
        else
          # No : store the line where the user failed to get created
          failed_user_creations << [line, "erreur: les informations du propriétaire ne semblent pas être correctes"]
        end
      end

      line += 1
    end
    # Envoyer un email aux utilisateurs already existants avec le nombre d'apparts crées pour existing_user
    already_existing_users.each do |email, nb_of_appartments|
      UserMailer.send_new_flats_to_existing_user(email, nb_of_appartments)
    end
    # Construire l'array d'erreurs
    errors_array = []
    # errors_array is populated with all the errors from the csv with arrays => [N° of line where the error occured, type of error]
    failed_flat_creations.each { |failed_flat| errors_array << failed_flat }
    failed_user_creations.each { |failed_user| errors_array << failed_user }
    # Envoyer toutes les failed creations a l'mount_uploaders
    UserMailer.send_parsing_errors_to_uploader(errors_array)
  end

  def available_between(start_date, end_date)
    self.rentals.where(validated: true).each do |rental|
      if rental.end_date
        if start_date < rental.end_date && start_date >= rental.start_date
          return false
        elsif end_date <= rental.end_date && end_date > rental.start_date
          return false
        elsif start_date <= rental.start_date && end_date >= rental.end_date
          return false
        end
      else
        unless end_date <= rental.start_date
          return false
        end
      end
    end
    return true
  end

  def available_from(start_date)
    return available_between(start_date, start_date + 15)
  end

  def available_for(start_date, end_date)
    if end_date
      return available_between(start_date, end_date)
    else
      return available_from(start_date)
    end
  end
end
