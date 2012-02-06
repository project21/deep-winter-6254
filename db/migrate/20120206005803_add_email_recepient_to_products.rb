class AddEmailRecepientToProducts < ActiveRecord::Migration
  def change
    add_column :products, :email_recepient, :string
  end
end
