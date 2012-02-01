class RemoveStripeCardTokenFromProducts < ActiveRecord::Migration
  def up
    remove_column :products, :stripe_card_token
  end

  def down
    add_column :products, :stripe_card_token, :string
  end
end
