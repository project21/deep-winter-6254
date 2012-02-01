class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name
      t.text :description
      t.decimal :price ,:precision => 5, :scale => 2, :default => 1.00
      t.string :meta_keyword
      t.text :meta_description

      t.timestamps
    end
  end
end
