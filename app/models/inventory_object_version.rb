class InventoryObjectVersion < ActiveRecord::Base
  attr_accessible :name
  
  belongs_to :inventory_object_type	
  has_many :objects, :foreign_key => 'inventory_object_version_id', :class_name => 'InventoryObject'
end
