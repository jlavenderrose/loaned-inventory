class PointOfSaleController < ApplicationController
  def create
    @inventory_object = InventoryObject.new
  end
end
