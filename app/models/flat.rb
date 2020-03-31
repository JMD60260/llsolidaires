class Flat < ApplicationRecord
  mount_uploaders :photos, FlatPhotosUploader
  # serialize :photos, JSON
  enum flat_type: [:Studio, :T1, :T2, :T3, :T4]

  belongs_to :user
  has_many :rentals, dependent: :destroy

  validates :address, presence: true

  geocoded_by :address
  # do |obj, results|
  #   if geo = results.first
  #     obj.city = geo.city
  #   end
  # end

  after_validation :geocode, if: :will_save_change_to_address?


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
end
