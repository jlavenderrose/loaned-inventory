require 'test_helper'

class InventoryLoanTest < ActiveSupport::TestCase
	test "creates audit_log_entry on create" do
		#need Administrator.current to be set
		Administrator.current = administrators(:one)
		
		inventory_loan = InventoryLoan.new
		inventory_loan.inventory_object = inventory_objects(:two)
		inventory_loan.loanee = loanees(:one)
		inventory_loan.save
		
		assert inventory_loan.audit_log_entries.count != 0, "has audit log"
		assert inventory_loan.audit_log_entries.first.message.present?, "audit log has message"
	end
end
