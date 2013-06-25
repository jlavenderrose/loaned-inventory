class ReportEntryComment < ActiveRecord::Base
  attr_accessible :administrator_id, :body, :report_entry_id
  
  validate :body, :presence => true
  validate :administrator_id, :presence => true
  validate :report_entry_id, :presence => true
  
  belongs_to :report_entry
  belongs_to :administrator
end
