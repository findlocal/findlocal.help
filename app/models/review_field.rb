class ReviewField < ApplicationRecord
  belongs_to :review

  validates :name, :review, presence: true
  validate :rating_must_be_in_range

  private

  def rating_must_be_in_range
    errors.add(:rating, "must be between 1 and 5") unless rating&.between?(1, 5)
  end
end
