class Loanee < ActiveRecord::Base
  attr_accessible :fullname, :idnum

  has_many :inventory_loans
  has_many :objects, :through => :inventory_loans,
					 :foreign_key => 'inventory_object_id',
					 :class_name => 'InventoryObjects'
end
