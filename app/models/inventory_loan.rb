class InventoryLoan < ActiveRecord::Base
  attr_accessible :loaned_date, :returned_date, :loanee_id, :inventory_object_id
  
  belongs_to :inventory_object
  belongs_to :loanee
  
  validates_associated :inventory_object
  validates_associated :loanee
  #validates only current loan for each inventory_object
end
