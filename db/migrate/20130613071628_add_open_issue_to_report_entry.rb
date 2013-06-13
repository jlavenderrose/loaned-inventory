class AddOpenIssueToReportEntry < ActiveRecord::Migration
  def change
    add_column :report_entries, :open_issue, :boolean
  end
end
