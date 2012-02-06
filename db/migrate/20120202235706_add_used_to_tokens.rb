class AddUsedToTokens < ActiveRecord::Migration
  def change
    add_column :tokens, :used, :boolean,:default=>false
  end
end
