class CreateLoanees < ActiveRecord::Migration
  def change
    create_table :loanees do |t|
      t.string :fullname
      t.string :idnum

      t.timestamps
    end
  end
end
