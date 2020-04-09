# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :task_applications
  has_many :creators, class_name: 'Task', foreign_key: 'creator_id'
  has_many :helpers, class_name: 'Task', foreign_key: 'helper_id'
end
