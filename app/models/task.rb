class Task < ApplicationRecord
  # Associations
  belongs_to :creator, class_name: "User"
  belongs_to :helper, class_name: "User", optional: true
  has_many :helps, dependent: :destroy
  has_many :task_tags, dependent: :destroy
  has_many :tags, through: :task_tags
  has_many :reviews, dependent: :nullify
  has_many_attached :photos, dependent: :destroy

  # Validations
  validates :title, :description, :location, :status, presence: true
  validates :status, inclusion: { in: ["pending", "in progress", "completed"], message: "%{value} is not a valid status" }
  validates :tags, length: { maximum: 3, message: "can be maximum 3 for a task" }

  # Geolocation
  geocoded_by :location
  after_validation :geocode
  reverse_geocoded_by :latitude, :longitude, address: :location
  after_validation :reverse_geocode
end
