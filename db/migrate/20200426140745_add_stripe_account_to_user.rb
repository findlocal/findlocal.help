class AddStripeAccountToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :stripe_account, :string
  end
end
