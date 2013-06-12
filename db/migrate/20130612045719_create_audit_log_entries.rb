class CreateAuditLogEntries < ActiveRecord::Migration
  def change
    create_table :audit_log_entries do |t|
      t.string :desc

      t.timestamps
    end
  end
end
