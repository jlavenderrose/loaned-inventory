class InventoryObjectVersion < ActiveRecord::Base
  scope :type_sorted, order('inventory_object_type_id')

  attr_accessible :name, :inventory_object_type_name, :inventory_object_type_id
  
  def inventory_object_type_name
	inventory_object_type.name unless inventory_object_type.nil?
  end
  
  def inventory_object_type_name=(name)
	inventory_object_type = InventoryObjectType.find_by_name(name) or InventoryObjectType.create(name: name)
  end
  
  validates :name, :uniqueness => true
  validates_associated :inventory_object_type
  
  belongs_to :inventory_object_type	
  has_many :objects, :foreign_key => 'inventory_object_version_id', :class_name => 'InventoryObject'
end
