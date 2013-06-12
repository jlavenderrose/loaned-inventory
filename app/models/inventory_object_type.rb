class InventoryObjectType < ActiveRecord::Base
  attr_accessible :name
  
  has_many :versions, :foreign_key => 'inventory_object_type_id', :class_name => 'InventoryObjectVersion'
  has_many :inventory_objects, :through => :versions
end
