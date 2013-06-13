class InventoryObject < ActiveRecord::Base
  include FullTextQuery

  attr_accessible :id1, :id2, :id3, 
				  :inventory_object_version_id
  
  belongs_to :inventory_object_version
  has_many :inventory_loans
  has_many :loanees, :through => :inventory_loans
  
  has_many :report_entries
  
  validates :id1, :uniqueness => true, :presence => true
  validates :id2, :uniqueness => true, :allow_blank => true
  validates :id3, :uniqueness => true, :allow_blank => true
  validates_associated :inventory_object_version
  validates_presence_of :inventory_object_version_id
  
  accepts_nested_attributes_for :inventory_object_version
  
  def search(query)
    @res = like_query InventoryObject, {:id1 => query, :id2 => query, :id3 => query}
    if @res.length == 1 then
      @res.first
    else
      @res
    end
  end
end
