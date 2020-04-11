class User < ApplicationRecord
  # Constants at the top:
  PHONE_REGEX = /\A(\(?\+?[0-9]*\)?)?[0-9_\- \(\)]*\z/

  # Devise:
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

  # Associations:
  has_many :task_applications
  has_many :tasks, through: :task_applications
  has_one_attached :avatar

  # Validations:
  validates :first_name, :last_name, length: { minimum: 2, maximum: 20 }, presence: true
  # use the regex from devise (it's just an helper the gem is giving us):
  validates :email, format: { with: Devise::email_regexp, message: "is not a valid email" }
  validates :phone_number, format: { with: PHONE_REGEX, message: "is not a valid phone number" }
  validates_associated :task_applications, :tasks

  # Custom methods and aliases:
  def applications # just an alias
    task_applications
  end

  def accepted_tasks # find all tasks where the current user was picked to be the helper
    tasks.where(helper: self)
  end

  def created_tasks
    tasks
  end
end
