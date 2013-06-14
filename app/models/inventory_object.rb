class InventoryObject < ActiveRecord::Base
  include FullTextQuery

  attr_accessible :id1, :id2, :id3,
          :name, :status_tag_list,
				  :inventory_object_version_id
          
  acts_as_taggable_on :status_tags
  
  belongs_to :inventory_object_version
  has_many :inventory_loans
  has_many :loanees, :through => :inventory_loans
  
  has_many :report_entry_objects
  has_many :report_entries, :through => :report_entry_objects
  
  validates :id1, :uniqueness => true, :presence => true
  validates :id2, :uniqueness => true, :allow_blank => true
  validates :id3, :uniqueness => true, :allow_blank => true
  validates_associated :inventory_object_version
  validates_presence_of :inventory_object_version_id
  
  def search(query)
    @res = like_query InventoryObject, {:id1 => query, :id2 => query, :id3 => query}
    if @res.length == 1 then
      @res.first
    else
      @res
    end
  end
  
  #jQuery.tokenInput support
  def as_json options=nil
    {
      id: self.id,
      name: [self.id1, self.id2, self.id3].join(' ')
    }
  end

  #CSV export support
  comma do
    inventory_type_name 'Type'
    inventory_version_name 'Version'
    
    id1 'id1'
    id2 'id2'
    id3 'id3'
  end
  
  #CSV getters
  def inventory_version_name
    inventory_object_version.name
  end
  
  def inventory_type_name
    inventory_object_version.inventory_object_type.name
  end
end
