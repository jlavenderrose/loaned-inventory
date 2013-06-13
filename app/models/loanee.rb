class Loanee < ActiveRecord::Base
  include FullTextQuery

  attr_accessible :fullname, :idnum

  has_many :inventory_loans
  has_many :objects, :through => :inventory_loans,
					 :foreign_key => 'inventory_object_id',
					 :class_name => 'InventoryObjects'

  def search(query)
    @res = like_query Loanee, {:fullname => query, :idnum => query}
    if @res.length == 1 then
      @res.first
    else
      @res
    end
  end
end
