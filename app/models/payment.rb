class Payment < ApplicationRecord
  belongs_to :task
  belongs_to :help

  validates :task, :help, :checkout_session_id, presence: true
end
