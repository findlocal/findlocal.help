# frozen_string_literal: true

class AddReferencesToUsers < ActiveRecord::Migration[6.0]
  def change
    add_reference :users, :task_application, null: false, foreign_key: true
    add_reference :users, :task, null: false
  end
end
