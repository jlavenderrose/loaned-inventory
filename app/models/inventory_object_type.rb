class InventoryObjectType < ActiveRecord::Base
  attr_accessible :name
  
  has_many :inventory_object_versions
  has_many :inventory_objects, :through => :inventory_object_versions
end
