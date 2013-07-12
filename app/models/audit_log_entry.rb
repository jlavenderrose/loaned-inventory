class AuditLogEntry < ActiveRecord::Base
  include ActionView::Helpers::UrlHelper

  attr_accessible :desc
  
  belongs_to :auditable, polymorphic: true
  belongs_to :administrator
  
  def message
	desc
  end
end
