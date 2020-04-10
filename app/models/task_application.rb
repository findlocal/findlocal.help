class TaskApplication < ApplicationRecord
  belongs_to :user
  belongs_to :task

  validates :user, presence: true
  validates :task, presence: true
end
