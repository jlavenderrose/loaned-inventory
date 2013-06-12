class AddTypeVersionToInventoryObject < ActiveRecord::Migration
  def change
    add_column :inventory_objects, :inventory_object_type_id, :integer
    add_column :inventory_objects, :inventory_object_version_id, :integer
  end
end
