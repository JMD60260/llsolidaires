class Flat < ApplicationRecord
  belongs_to :user
  has_many :rentals

  validates :address, presence: true

  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?

end
