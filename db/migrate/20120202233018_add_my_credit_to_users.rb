class AddMyCreditToUsers < ActiveRecord::Migration
  def change
    add_column :users, :my_credit, :integer,:default=>0
  end
end
