class User < ApplicationRecord
  mount_uploader :identity_file, IdentityFileUploader
  mount_uploader :proof, ProofUploader
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum role: [:owner, :medical]

  has_many :flats, dependent: :destroy
  has_many :rentals, dependent: :destroy

  after_initialize do
    if self.new_record?
      self.role ||= :medical
    end
  end

  validates :role, :phone, :last_name, presence: true
end
