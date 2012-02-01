class CreateTokens < ActiveRecord::Migration
  def change
    create_table :tokens do |t|
      t.string :unique_token
      t.integer :user_id
      t.integer :product_id
      t.string :stripe_card_token

      t.timestamps
    end
  end
end
