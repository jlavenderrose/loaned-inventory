class PointOfSaleController < ApplicationController
  
  
  def create
    @inventory_object = InventoryObject.new
    @session_params = {id1: true, id2: false, id3: false}
  end
  
  def tag
    @session_params = params[:pos_session]
    @session_params ||= {id2: 0, id3: 0}
    
    if params[:inventory_object] then
      @inventory_object = InventoryObject.find_or_initialize_by_id1(:id1 => params[:inventory_object][:id])
      if @inventory_object.new_record? then
        @inventory_object = InventoryObject.new(params[:inventory_object])
        if @inventory_object.save then
          flash[:info] = 'Sucessfully created new InventoryObject'
        else
          flash[:error] = 'Failed to create new InventoryObject'
        end
      else
        @inventory_object.status_tag_list.add(params[:inventory_object][:status_tag_list])
        flash[:info] = 'Sucesfully tagged InventoryObject'
      end
    end
    @inventory_object = InventoryObject.new(params[:inventory_object])
    render 'tag'
  end
end
