class User < ApplicationRecord
  # N.B: the order of the methods is not important, but can help us organize the different parts of the model

  # 1. Constants
  PHONE_REGEX = /\A(\(?\+?[0-9]*\)?)?[0-9_\- \(\)]*\z/.freeze # freeze it to have an actual costant

  # 2. Devise -> https://github.com/heartcombo/devise/wiki
  devise :database_authenticatable, :registerable, :rememberable, :validatable
  # Others modules: :recoverable, :confirmable, :lockable, :timeoutable, :trackable, :omniauthable

  # 3. Associations
  has_many :helps, dependent: :destroy
  has_many :tasks, through: :helps
  has_one_attached :avatar, dependent: :destroy

  # 4. Validations
  validates :first_name, :last_name, presence: true, length: { minimum: 2, maximum: 20 }
  validates :email, format: { with: Devise.email_regexp, message: "is not a valid email" } # the regex here is from devise
  validates :phone_number, format: { with: PHONE_REGEX, message: "is not a valid phone number" }

  # 5. Custom methods
  def shortname
    "#{first_name.capitalize} #{last_name.capitalize[0]}."
  end

  def created_tasks
    Task.where(creator: self) # *self* refers to the same instance of the user
  end

  def helper_tasks
    Task.where(helper: self)
  end
end
