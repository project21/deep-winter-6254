class AddRegularPriceToProducts < ActiveRecord::Migration
  def change
    add_column :products, :regular_price, :decimal , :precision => 10, :scale => 2
  end
end
