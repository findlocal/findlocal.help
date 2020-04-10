# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :first_name, :last_name, length: { minimum: 2, maximum: 20 }, presence: true
  validates :email, format: { with: ^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$ } #expression matches email addresses, and checks that they are of the proper form. It checks to ensure the top level domain is between 2 and 4 characters long, but does not check the specific domain against a list
  validates :password, :address, presence: true #do we want to have a max password length?
  validates :phone_number, format: {with :  ^(\(?\+?[0-9]*\)?)?[0-9_\- \(\)]*$ }#regex for number with international dialing code
  validates_associated :task_applications, :tasks, :creators, :helpers


  has_many :task_applications
  has_many :tasks, through: :task_applications
  has_many :creators, class_name: 'Task', foreign_key: 'creator_id'
  has_many :helpers, class_name: 'Task', foreign_key: 'helper_id'

  def applications # alias
    task_applications
  end

  def accepted_applications
    # find all tasks where the current user was picked to be the helper
    # (chances are in the current seed script there will be none)
    tasks.where(helper: id)
  end
end
