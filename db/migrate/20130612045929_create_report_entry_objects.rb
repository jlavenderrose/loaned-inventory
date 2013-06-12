class CreateReportEntryObjects < ActiveRecord::Migration
  def change
    create_table :report_entry_objects do |t|

      t.timestamps
    end
  end
end
