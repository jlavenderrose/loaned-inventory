class ReportEntry < ActiveRecord::Base
  attr_accessible :body, :open_issue, 
                  :administrator_id, 
                  :inventory_object_name, :inventory_object_id
  
  validates :body, :presence => true
  validates :administrator_id, :presence => true
  
  belongs_to :inventory_object
  belongs_to :administrator
  
  def inventory_object_name=(name)
    object = InventoryObject.new.search(name)
    self.inventory_object = object unless object.respond_to?('count')
  end

  def inventory_object_name
    self.inventory_object.nil? ? "" : self.inventory_object.id1 
  end
end
