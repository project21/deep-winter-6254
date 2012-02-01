class AddNameToTokens < ActiveRecord::Migration
  def change
    add_column :tokens, :name, :string
  end
end
