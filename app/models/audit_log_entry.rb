class AuditLogEntry < ActiveRecord::Base
  attr_accessible :desc
  
  belongs_to :auditable, polymorphic: true
end
