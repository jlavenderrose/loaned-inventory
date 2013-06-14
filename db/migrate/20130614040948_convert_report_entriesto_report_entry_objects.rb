class ConvertReportEntriestoReportEntryObjects < ActiveRecord::Migration
  def up
	report_entries = ReportEntry.all

	report_entries.each do |report|
		if report.inventory_object_id then
			report.inventory_object_ids = [report.inventory_object_id]
		end
	end
  end

  def down
  end
end
