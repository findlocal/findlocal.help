# frozen_string_literal: true

class AddReferencesToTasks < ActiveRecord::Migration[6.0]
  def change
    add_reference :tasks, :creator
    add_reference :tasks, :helper
  end
end
