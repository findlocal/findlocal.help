class Task < ApplicationRecord
  # Associations
  belongs_to :creator, class_name: "User"
  belongs_to :helper, class_name: "User", optional: true
  has_many :helps, dependent: :destroy
  has_many :task_tags, dependent: :destroy
  has_many :tags, through: :task_tags
  has_many_attached :photos, dependent: :destroy

  # Validations
  validates :title, :description, :location, :status, presence: true
  validate :due_date_cannot_be_in_the_past

  private

  def due_date_cannot_be_in_the_past
    errors.add(:due_date, "can't be in the past") if due_date.present? && due_date < Date.today
  end

  def reindex
    Task.reindex
  end

end
