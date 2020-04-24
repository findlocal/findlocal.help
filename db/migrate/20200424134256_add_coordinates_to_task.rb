class AddCoordinatesToTask < ActiveRecord::Migration[6.0]
  def change
    add_column :tasks, :latitude, :float
    add_column :tasks, :longitude, :float
  end
end
