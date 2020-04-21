class Review < ApplicationRecord
  belongs_to :task
  belongs_to :user
  has_many :review_fields, dependent: :destroy

  alias_attribute :fields, :review_fields

  validates :user, presence: true
  validates :task, presence: true
  validate :task_must_have_an_helper
  validate :user_must_be_creator_or_helper

  private

  def task_must_have_an_helper
    errors.add(:task, "must have an helper") unless task&.helper
  end

  def user_must_be_creator_or_helper
    errors.add(:user, "must be the task creator or helper") unless task && [task.creator, task.helper].include?(user)
  end
end
