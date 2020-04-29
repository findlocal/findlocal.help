class AddBidToHelp < ActiveRecord::Migration[6.0]
  def change
    add_monetize(:helps, :bid, currency: { present: false })
  end
end
