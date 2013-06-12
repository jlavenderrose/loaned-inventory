class InventoryObjectVersion < ActiveRecord::Base
  attr_accessible :name
  
  belongs_to :inventory_object_type	
  has_many :inventory_objects
end
