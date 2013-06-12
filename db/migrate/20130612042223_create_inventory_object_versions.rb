class CreateInventoryObjectVersions < ActiveRecord::Migration
  def change
    create_table :inventory_object_versions do |t|
      t.string :name

      t.timestamps
    end
  end
end
