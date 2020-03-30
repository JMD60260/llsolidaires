class Flat < ApplicationRecord
  mount_uploaders :photos, FlatPhotosUploader
  # serialize :photos, JSON
  enum flat_type: [:Studio, :T1, :T2, :T3, :T4]

  belongs_to :user
  has_many :rentals, dependent: :destroy

  validates :address, presence: true

  geocoded_by :address do |obj, results|
    if geo = results.first
      obj.city = geo.city
    end
  end


  after_validation :geocode, if: :will_save_change_to_address?




end
