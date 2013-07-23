class InventoryObjectType < ActiveRecord::Base
  attr_accessible :name
  
  has_many :inventory_object_versions, :foreign_key => 'inventory_object_type_id', :class_name => 'InventoryObjectVersion' do
	def findcreate(name)
		proxy_association.owner.inventory_object_versions.find_by_name(name) or proxy_association.owner.inventory_object_versions.create(name: name)
	end
  end
  has_many :inventory_objects, :through => :inventory_object_versions
  
  def findcreate(name)
	InventoryObjectType.find_by_name(name) or InventoryObjectType.create(name: name)
  end
end
