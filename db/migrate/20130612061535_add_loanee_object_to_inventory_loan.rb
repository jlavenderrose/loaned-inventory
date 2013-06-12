class AddLoaneeObjectToInventoryLoan < ActiveRecord::Migration
  def change
    add_column :inventory_loans, :inventory_object_id, :integer
    add_column :inventory_loans, :loanee, :integer
  end
end
