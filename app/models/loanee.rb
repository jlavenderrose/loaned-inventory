class Loanee < ActiveRecord::Base
  attr_accessible :fullname, :idnum

  has_many :inventory_loans
  has_many :inventory_objects, :through => :inventory_loans
end
