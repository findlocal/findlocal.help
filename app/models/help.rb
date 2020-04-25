class Help < ApplicationRecord
  belongs_to :user
  belongs_to :task
  monetize :bid_cents

  validates :user, presence: true
  validates :task, presence: true
  validates :bid_cents, presence: true
end
