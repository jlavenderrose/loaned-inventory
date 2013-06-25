class ReportEntry < ActiveRecord::Base
  include InventoryObjectTokenInputtable
  include FullTextQuery

  attr_accessible :body, :open_issue, 
                  :administrator_id
  
  validates :body, :presence => true
  validates :administrator_id, :presence => true
  validate :inventory_objects_associated
  
  has_many :report_entry_objects
  has_many :inventory_objects, :through => :report_entry_objects
  has_many :report_entry_comments
  belongs_to :administrator
  
  def search query
	like_query ReportEntry, {:body => query}
  end
  
  def self.search query
	self.new.search query
  end
  
  def path_object
	if inventory_objects.count > 1 then
		self
	else
		self.inventory_objects.first
	end
  end
  
  private
  def inventory_objects_associated
    errors.add(:inventory_object_tokens,
      "A ReportEntry must be associated with atleast one InventoryObject") if
      self.inventory_object_ids.count == 0
  end
end
