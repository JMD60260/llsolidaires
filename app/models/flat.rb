class Flat < ApplicationRecord
  mount_uploaders :photos, FlatPhotosUploader
  # serialize :photos, JSON
  enum flat_type: [:Studio, :T1, :T2, :T3, :T4]

  belongs_to :user
  has_many :rentals, dependent: :destroy

  validates :address, presence: true

  geocoded_by :address

  validate :found_address_presence?
  after_validation :geocode, if: :will_save_change_to_address?
  after_save :define_city

  def define_city
    return unless city.present?
    geocoded_adress = Geocoder.search("#{self.latitude}, #{self.longitude}")[0].data["address"]
    geocoded_city = geocoded_adress["city"]
    geocoded_town = geocoded_adress["town"]
    (geocoded_city != nil) ? self.city = geocoded_city : self.city = geocoded_town
  end

  def found_address_presence?
    # Impossible de raise des flashes d'erreurs ici, donc cette methode renvoie une 500 si ladresse n'est pas géocodable. A ameliorer
    if self.geocode == nil || self.geocode[1] == nil
      errors.add(:address, "Cette addresse n'est pas valide, merci de la compléter.")
    end
  end

  def self.import(file)
    csv_options = { col_sep: ';', quote_char: '"', headers: :first_row }
    CSV.foreach(file.path, csv_options) do |row|
      # Creating or finding the owner
      if User.find_by(email: row[2])
        # Creating the related flat
        existing_user = User.find_by(email: row[2])
        flat_infos = {
          user: existing_user,
          address: row[14],
          flat_type: "T1",
          description: "Parking: #{row[6]}\nLinge fourni: #{row[8]}\nRemise des clés: #{row[10]}",
          city: row[5]
        }
        Flat.create!(flat_infos)
      else
        # Create this user
        random_password = (('0'..'9').to_a + ('A'..'Z').to_a + ('a'..'z').to_a).shuffle.first(6).join
        user_infos = {
          last_name: row[0],
          first_name: row[1],
          phone: row[3],
          email: row[2],
          password: random_password,
          from_csv: true,
          role: "owner",
          rgpd: true
        }
        new_user = User.create!(user_infos)

        # Create his related flat
        flat_infos = {
          user: new_user,
          address: row[14],
          flat_type: "T1",
          description: "Parking: #{row[6]}\nLinge fourni: #{row[8]}\nRemise des clés: #{row[10]}",
          city: row[5]
        }
        Flat.create!(flat_infos)
      end
    end
  end

  def available_between(start_date, end_date)
    self.rentals.where(validated: true).each do |rental|
      if rental.end_date
        if start_date <= rental.end_date && start_date >= rental.start_date
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
    return available_from(start_date, start_date + 15)
  end

  def available_for(start_date, end_date)
    if end_date
      return available_between(start_date, end_date)
    else
      return available_from(start_date)
    end
  end
end
