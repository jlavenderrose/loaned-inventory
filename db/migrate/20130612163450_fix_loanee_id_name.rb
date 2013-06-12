class FixLoaneeIdName < ActiveRecord::Migration
	def change
		rename_column :inventory_loans, :loanee, :loanee_id
	end
end
