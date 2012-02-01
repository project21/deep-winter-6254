class AddStripeCardTokenToProducts < ActiveRecord::Migration
  def change
    add_column :products, :stripe_card_token, :string
  end
end
