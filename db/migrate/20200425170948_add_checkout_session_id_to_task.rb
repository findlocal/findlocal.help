class AddCheckoutSessionIdToTask < ActiveRecord::Migration[6.0]
  def change
    add_column :tasks, :checkout_session_id, :string
  end
end
