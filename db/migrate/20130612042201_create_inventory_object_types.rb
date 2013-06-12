class CreateInventoryObjectTypes < ActiveRecord::Migration
  def change
    create_table :inventory_object_types do |t|
      t.string :name

      t.timestamps
    end
  end
end
