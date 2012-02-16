class CreatePlayers < ActiveRecord::Migration
  def change
    create_table :players do |t|
      t.string :email
      t.integer :product_id
      t.timestamps
    end
  end
end
