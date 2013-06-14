class ReportEntry < ActiveRecord::Base
  attr_accessible :body, :open_issue, 
                  :administrator_id, 
                  :inventory_object_name, :inventory_object_id
  
  attr_reader :inventory_object_tokens
  
  validates :body, :presence => true
  validates :administrator_id, :presence => true
  
  has_many :report_entry_objects
  has_many :inventory_objects, :through => :report_entry_objects
  belongs_to :administrator
  
  def inventory_object_tokens=(ids)
    self.inventory_object_ids = ids.split(",")
  end
end
