class InventoryObjectType < ActiveRecord::Base
  attr_accessible :name
  
  has_many :versions, :foreign_key => 'inventory_object_type_id', :class_name => 'InventoryObjectVersion' do
	def findcreate(name)
		proxy_association.owner.versions.find_by_name(name) or proxy_association.owner.versions.create(name)
	end
  end
  has_many :inventory_objects, :through => :versions
  
  def findcreate(name)
	InventoryObjectType.find_by_name(name) or InventoryObjectType.create(name: name)
  end
end
