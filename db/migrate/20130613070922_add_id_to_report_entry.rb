class AddIdToReportEntry < ActiveRecord::Migration
  def change
    add_column :report_entries, :inventory_object_id, :integer
  end
end
