class AddWinnerToProducts < ActiveRecord::Migration
  def change
    add_column :products, :winner, :string
  end
end
