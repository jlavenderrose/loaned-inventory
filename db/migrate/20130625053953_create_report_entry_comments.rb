class CreateReportEntryComments < ActiveRecord::Migration
  def change
    create_table :report_entry_comments do |t|
      t.text :body
      t.integer :administrator_id
      t.integer :report_entry_id

      t.timestamps
    end
  end
end
