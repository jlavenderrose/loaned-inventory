class AddAdministratorReferenceToAuditLogEntry < ActiveRecord::Migration
  def change
	change_table :audit_log_entries do |t|
		t.references :administrator
	end
  end
end
