class CreateReportEntries < ActiveRecord::Migration
  def change
    create_table :report_entries do |t|
      t.text :body

      t.timestamps
    end
  end
end
