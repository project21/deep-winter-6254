class AddBuckToTokens < ActiveRecord::Migration
  def change
    add_column :tokens, :buck, :integer
  end
end
