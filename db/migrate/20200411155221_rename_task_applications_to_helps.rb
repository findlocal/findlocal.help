class RenameTaskApplicationsToHelps < ActiveRecord::Migration[6.0]
  def change
    rename_table :task_applications, :helps
  end
end
