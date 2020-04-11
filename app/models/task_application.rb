class TaskApplication < ApplicationRecord
  belongs_to :user, null: false
  belongs_to :task, null: false

  validates :user, presence: true
  validates :task, presence: true
end
