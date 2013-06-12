class InventoryLoan < ActiveRecord::Base
  attr_accessible :loaned_date, :returned_date
  
  belongs_to :inventory_object
  belongs_to :loanee
end
