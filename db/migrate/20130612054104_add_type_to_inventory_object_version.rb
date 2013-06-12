class AddTypeToInventoryObjectVersion < ActiveRecord::Migration
  def change
    add_column :inventory_object_versions, :inventory_object_type_id, :integer
  end
end
