class AddMessageToHelp < ActiveRecord::Migration[6.0]
  def change
    add_column :helps, :message, :text
  end
end
