class Flat < ApplicationRecord
  mount_uploaders :photos, FlatPhotosUploader
  # serialize :photos, JSON

  belongs_to :user
  has_many :rentals

  validates :address, presence: true

  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?

end
