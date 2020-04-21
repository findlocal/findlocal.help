class CreateReviewFields < ActiveRecord::Migration[6.0]
  def change
    create_table :review_fields do |t|
      t.string(:name)
      t.text(:content)
      t.integer(:rating)
      t.references(:review, null: false, foreign_key: true)

      t.timestamps
    end
  end
end
