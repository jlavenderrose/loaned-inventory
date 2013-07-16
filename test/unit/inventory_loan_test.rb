require 'test_helper'

class InventoryLoanTest < ActiveSupport::TestCase
	test "creates audit_log_entry on create" do
		#need Administrator.current to be set
		Administrator.current = administrators(:one)
		inventory_loan = InventoryLoan.new
		
		assert_difference ('inventory_loan.audit_log_entries.count') do 
			inventory_loan.inventory_object = inventory_objects(:two)
			inventory_loan.loanee = loanees(:one)
			inventory_loan.save
		end
	
		assert inventory_loan.audit_log_entries.last.message.present?, "audit log has message"
	end
	
	test "creates audit_log_entry on returned_date change" do
		#need Administrator.current to be set
		Administrator.current = administrators(:one)
		inventory_loan = InventoryLoan.find(inventory_loans(:one).id)
		
		assert_difference ('inventory_loan.audit_log_entries.count') do 
			inventory_loan.update_attributes(returned_date: Date.today)
		end
	
		assert inventory_loan.audit_log_entries.last.message.present?, "audit log has message"
	end
end
