class InventoryObject < ActiveRecord::Base
  include FullTextQuery
  include InventoryObjectTokenInputtable

  attr_accessible :id1, :id2, :id3,
          :name, :status_tag_list,
				  :inventory_object_version_id
          
  acts_as_taggable_on :status_tags
  ActsAsTaggableOn.force_lowercase = true
  
  belongs_to :inventory_object_version
  has_many :inventory_loans
  has_many :loanees, :through => :inventory_loans
  
  has_many :report_entry_objects 
  has_many :report_entries, :through => :report_entry_objects do
    def open?
      proxy_association.owner.report_entries.each do |report|
        return true if report.open_issue
      end
      return false
    end
  end
  
  has_many :audit_log_entries, as: :auditable
  
  validates :id1, :uniqueness => true, :presence => true
  validates :id2, :uniqueness => true, :allow_blank => true
  validates :id3, :uniqueness => true, :allow_blank => true
  validates_associated :inventory_object_version
  validates_presence_of :inventory_object_version_id
  
  after_create do
	self.audit_log_entries.create(administrator_id: Administrator.current.id,
								  desc: "%a created %o at #{self.created_at}")
  end
  
  around_update :around_update_status_tag_list
  
  def around_update_status_tag_list
	changed = self.changed
	old_tags = self.status_tag_list_was.split ", "
	yield
	if changed.include? "status_tag_list" then
		audit_log_entry = self.audit_log_entries.new
		audit_log_entry.administrator = Administrator.current
		
		new_tags = self.status_tag_list.split ", "
		removed = old_tags - new_tags
		added = new_tags - old_tags
		logger.debug new_tags
		logger.debug old_tags
		
		audit_log_entry.desc = "%a updated status_tags "
		audit_log_entry.desc += "added: #{added.join(", ")}" if added.present?
		audit_log_entry.desc += "removed: #{removed.join(", ")}" if removed.present?
		
		audit_log_entry.save
	end
  end
  
  def human_name
    "#{self.inventory_object_version.name}: #{self.id1} #{self.id2} #{self.id3}"
  end
  
  def search(query, scope=nil)
    scope = scope || InventoryObject
    @res = like_query scope, {:id1 => query, :id2 => query, :id3 => query}
    if @res.length == 1 then
      @res.first
    else
      @res
    end
  end
  
  def self.search query, scope=nil
    InventoryObject.new.search query, scope
  end
  
  #jQuery.tokenInput support
  def as_json options=nil
    {
      id: self.id,
      tid: "o#{self.id}",
      name: self.human_name
    }
  end

  #CSV export support
  comma do
    inventory_type_name 'Type'
    inventory_version_name 'Version'
    
    id1 'id1'
    id2 'id2'
    id3 'id3'
    
    status_tag_list 'Status Tags'
  end
  
  #CSV getters
  def inventory_version_name
    inventory_object_version.name
  end
  
  def inventory_type_name
    inventory_object_version.inventory_object_type.name
  end
end
