class AddForeignKeysToReportEntry < ActiveRecord::Migration
  def change
	add_column :report_entries, :administrator_id, :integer
	add_column :report_entry_objects, :report_entry_id, :integer
	add_column :report_entry_objects, :inventory_object_id, :integer
  end
end
