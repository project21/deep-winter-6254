class AddNoOfWinningToUsers < ActiveRecord::Migration
  def change
    add_column :users, :no_of_winning, :integer,:default=>0
  end
end
