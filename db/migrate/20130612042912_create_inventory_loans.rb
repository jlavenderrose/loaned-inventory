class CreateInventoryLoans < ActiveRecord::Migration
  def change
    create_table :inventory_loans do |t|
      t.date :loaned_date
      t.date :returned_date

      t.timestamps
    end
  end
end
