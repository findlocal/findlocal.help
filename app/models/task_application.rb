class TaskApplication < ApplicationRecord
  belongs_to :user
  belongs_to :task

  validates :user, presence: true, null: false
  validates :task, presence: true, null: false
end
