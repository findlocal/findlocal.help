# frozen_string_literal: true

class Task < ApplicationRecord
  belongs_to :creator, class_name: 'User'
  belongs_to :helper, class_name: 'User'
  has_many :task_tags
  has_many :tags, through: :task_tags

  validates :title, :description, :due_date, :location, :status, presence: true
  validates_associated :task_tags, :tags
end
