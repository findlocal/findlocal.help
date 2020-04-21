class CreateReviews < ActiveRecord::Migration[6.0]
  def change
    create_table :reviews do |t|
      t.float(:rating)
      t.references(:task, null: false, foreign_key: true)
      t.references(:user, null: false, foreign_key: true)

      t.timestamps
    end
  end
end
