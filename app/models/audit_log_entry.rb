class AuditLogEntry < ActiveRecord::Base
  #include ActionView::Helpers::UrlHelper
  #include ActionController::UrlFor
  #include Rails.application.routes.url_helpers
  
  #todo, figure out how to generate links here...

  attr_accessible :desc
  
  belongs_to :auditable, polymorphic: true
  belongs_to :administrator
  
  def message
    
	res = desc
	if desc.include? "%o" then
		res = res.sub(/\%o/, auditable.audit_name)
	end
	if desc.include? "%a" then
		res = res.sub(/\%a/, administrator.fullname)
	end
	res
  end
end
