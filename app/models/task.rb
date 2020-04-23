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
  validate :validate_tags
  # validate :due_date_cannot_be_in_the_past

  private

  # def due_date_cannot_be_in_the_past
  #   errors.add(:due_date, "must be in the future") if due_date.present? && due_date <= Time.zone.today
  # end

  def validate_tags
    errors.add(:tags, "You have included too many tags") if tags.size > 3
  end
end
