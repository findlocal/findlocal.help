class AddDefaultStatusToTasks < ActiveRecord::Migration[6.0]
  def change
    change_column_default :tasks, :status, "pending"
  end
end
