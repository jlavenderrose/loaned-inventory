class AddAuditableToAuditLogEntry < ActiveRecord::Migration
  def change
	change_table :audit_log_entries do |t|
		t.references :auditable, polymorphic: true
	end
  end
end
