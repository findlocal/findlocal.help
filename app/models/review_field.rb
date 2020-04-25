class ReviewField < ApplicationRecord
  belongs_to :review

  validates :name, :review, presence: true
  validate :rating_must_exist_and_be_in_range

  private

  def rating_must_exist_and_be_in_range
    return unless ["Communication", "Accuracy of Task Description", "Availability"].include?(name) && rating&.between?(1, 5)

    errors.add(:rating, "must be between 1 and 5")
  end
end
