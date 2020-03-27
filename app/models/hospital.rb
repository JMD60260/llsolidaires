class Hospital < ApplicationRecord
  validates :address, :name, presence: true
end
