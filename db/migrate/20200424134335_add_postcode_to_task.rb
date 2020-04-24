class AddPostcodeToTask < ActiveRecord::Migration[6.0]
  def change
    add_column :tasks, :postcode, :integer
  end
end
