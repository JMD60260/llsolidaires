class Rental < ApplicationRecord
  belongs_to :user
  belongs_to :flat

  validates :start_date, presence: true
  # validate :date_start_after_today?
  # validate :end_date_after_start_date?

  private

  def date_start_after_today?
    return if start_date.blank?

    errors.add(:start_date, "must be equal or after today") if start_date < Date.today
  end

  def end_date_after_start_date?
    return if start_date.blank? || end_date.blank?

    errors.add(:end_date, "must be after the start date") if end_date < start_date
  end

end
