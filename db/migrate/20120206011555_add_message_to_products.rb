class AddMessageToProducts < ActiveRecord::Migration
  def change
    add_column :products, :message, :text
  end
end
