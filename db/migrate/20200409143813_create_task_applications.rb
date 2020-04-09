class CreateTaskApplications < ActiveRecord::Migration[6.0]
  def change
    create_table :task_applications do |t|

      t.timestamps
    end
  end
end
