class CreateInventoryObjects < ActiveRecord::Migration
  def change
    create_table :inventory_objects do |t|
      t.string :id1
      t.string :id2
      t.string :id3

      t.timestamps
    end
  end
end
