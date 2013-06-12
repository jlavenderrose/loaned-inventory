class InventoryLoan < ActiveRecord::Base
  attr_accessible :loaned_date, :returned_date, :loanee_id, :inventory_object_id, :loanee_name, :inventory_object_name
  
  belongs_to :inventory_object
  belongs_to :loanee
  
  validates_associated :inventory_object
  validates_associated :loanee
  validate :only_current_loan, :on => :create
  
  #is this loan current?
  def current?
	returned_date.nil?
  end
  
  private
  #validates that there is only one current loan for each inventory_object
  def only_current_loan
	#if the attached object has another other current loans give an error
	if (inventory_object.inventory_loans.select {|loan| loan.current? && loan != self}).count != 0 then
		errors.add(:inventory_object, "An Inventory Object may only be loaned to one Loanee at a time!")
	end
  end
end
