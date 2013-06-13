class ReportEntryObject < ActiveRecord::Base
  validates :report_entry_id, :presence => true
  validates :inventory_object_id, :presence => true
  
  belongs_to :report_entry
  belongs_to :inventory_object
end
