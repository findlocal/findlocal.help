class CreatePayments < ActiveRecord::Migration[6.0]
  def change
    create_table :payments do |t|
      t.references(:task, null: false, foreign_key: true)
      t.references(:help, null: false, foreign_key: true)
      t.string(:checkout_session_id)
      t.boolean(:completed)

      t.timestamps
    end
  end
end
