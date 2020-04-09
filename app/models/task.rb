# frozen_string_literal: true

class Task < ApplicationRecord
  belongs_to :creator, class_name: 'User'
  belongs_to :helper, class_name: 'User'
end
