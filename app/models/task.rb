class Task < ApplicationRecord
  after_update :mark_as_in_progress!

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
  geocoded_by :location, latitude: :lat, longitude: :lon
  reverse_geocoded_by :latitude, :longitude, address: :location
  after_validation :reverse_geocode

  def mark_as_in_progress!
    update!(status: "in progress") if status == "pending" && helper.present?
  end
end
