require 'test_helper'

class AuditLogEntryTest < ActiveSupport::TestCase
	test "admin message subtitutions" do
		audit_log = AuditLogEntry.find(audit_log_entries(:one))
		
		assert audit_log.message.include?(audit_log.administrator.fullname), "performs substitution for administrator name"
	end
	
	test "auditable message substitutitons" do
		audit_log = AuditLogEntry.find(audit_log_entries(:one))
		
		assert audit_log.message.include?(audit_log.auditable.name), "performs substitution for auditable.name"
	end
end
