class Task < ApplicationRecord
  belongs_to :creator, class_name: 'User'
  belongs_to :helper, class_name: 'User'
  has_many :task_tags
  has_many :tags, through: :task_tags
  has_many :task_applications
  has_many_attached :photos

  def applications # alias
    task_applications
  end

  validates :title, :description, :location, :status, presence: true
  validates_associated :task_tags, :tags
end
