class InventoryObject < ActiveRecord::Base
  attr_accessible :id1, :id2, :id3, 
				  :inventory_object_version_id
  
  belongs_to :inventory_object_version
  has_many :inventory_loans
  has_many :loanees, :through => :inventory_loans
  
  accepts_nested_attributes_for :inventory_object_version
end
