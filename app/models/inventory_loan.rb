class InventoryLoan < ActiveRecord::Base
  attr_accessible :loaned_date, :returned_date, :loanee_id, :inventory_object_id
  
  belongs_to :inventory_object
  belongs_to :loanee
  
  validates_associated :inventory_object
  validates_associated :loanee
  validate :only_current_loan
  #validates only current loan for each inventory_object
  
  #is this loan current?
  def current?
	returned_date.nil?
  end
  
  private
  def only_current_loan
	#if the attached object has another other current loans give an error
	if (inventory_object.inventory_loans.select {|loan| loan.current? && loan != self}).count then
		errors.add(:inventory_object, "An Inventory Object may only be loaned to one Loanee at a time!")
	end
  end
end
