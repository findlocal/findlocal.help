class User < ApplicationRecord
  # N.B: the order of the methods is not important, but can help organize the different parts of the model

  # 1. Constants
  PHONE_REGEX = /\A(\(?\+?[0-9]*\)?)?[0-9_\- \(\)]*\z/.freeze # .freeze is to make it an actual costant

  # 2. Devise -> https://github.com/heartcombo/devise/wiki
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

  # 3. Associations
  has_many :helps, dependent: :destroy
  has_many :tasks, through: :helps
  has_one_attached :avatar, dependent: :destroy

  # 4. Validations
  validates :first_name, :last_name, length: { minimum: 2, maximum: 20 }, presence: true
  validates :email, format: { with: Devise.email_regexp, message: "is not a valid email" } # the regex here is from devise
  validates :phone_number, format: { with: PHONE_REGEX, message: "is not a valid phone number" }

  # 5. Custom methods
  # All tasks created by the user
  def created_tasks
    Task.where(creator: self) # *self* refers to the instance of the user
  end

  # All tasks where the current user was picked to be the helper
  def helper_tasks
    tasks.where(helper: self)
  end
end
