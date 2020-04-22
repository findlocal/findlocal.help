class RemoveDueDateFromTask < ActiveRecord::Migration[6.0]
  def change
    remove_column(:tasks, :due_date)
  end
end
