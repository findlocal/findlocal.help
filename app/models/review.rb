class Review < ApplicationRecord
  belongs_to :task
  belongs_to :user
  has_many :review_field, dependent: :destroy

  validates :user, presence: true
  validates :task, presence: true

end
