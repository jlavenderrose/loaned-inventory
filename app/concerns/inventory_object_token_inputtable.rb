module InventoryObjectTokenInputtable
  extend ActiveSupport::Concern
  
  included do
    attr_accessible :inventory_object_tokens, :inventory_object_token
    attr_reader :inventory_object_tokens, :inventory_object_token
  end 
  
  def inventory_object_tokens=(ids)
    self.inventory_object_ids = ids.split(",")
  end
  
  def inventory_object_token=(ids)
    self.inventory_object_id = id
  end
end
