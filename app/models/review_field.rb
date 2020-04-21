class ReviewField < ApplicationRecord
  belongs_to :review

  validates :review, presence: true
end
