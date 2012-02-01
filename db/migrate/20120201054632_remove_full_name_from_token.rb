class RemoveFullNameFromToken < ActiveRecord::Migration
  def up
    remove_column :tokens, :full_name
  end

  def down
    add_column :tokens, :full_name, :string
  end
end
