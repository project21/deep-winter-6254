class AddFullNameToTokens < ActiveRecord::Migration
  def change
    add_column :tokens, :full_name, :string
  end
end
