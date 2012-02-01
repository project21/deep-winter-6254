class AddStripeToTokens < ActiveRecord::Migration
  def change
    add_column :tokens, :stripe_customer_token, :string
  end
end
