class PointOfSaleController < ApplicationController
  autocomplete :loanee, :total_id
  
  def create
    @inventory_object = InventoryObject.new
    @session_params = {id1: true, id2: false, id3: false}
  end
  
  def tag
    @session_params = params[:pos_session]
    @session_params = {id2: false, id3: false, first: true} if @session_params.nil?
    logger.debug @session_params.to_yaml
    
    if params[:inventory_object] then
      @inventory_object = InventoryObject.find_or_initialize_by_id1(:id1 => params[:inventory_object][:id1])
      logger.debug(@inventory_object.to_yaml)
      logger.debug(@inventory_object.new_record?)
      if @inventory_object.new_record? then
        @inventory_object = InventoryObject.new(params[:inventory_object])
        if @inventory_object.save then
          flash[:info] = 'Sucessfully created new InventoryObject'
        else
          flash[:error] = 'Failed to create new InventoryObject'
        end
      else
        @inventory_object.status_tag_list.add(params[:inventory_object][:status_tag_list].split(", "))
        @inventory_object.save
        flash[:info] = 'Sucesfully tagged InventoryObject'
      end
    end
    @inventory_object = InventoryObject.new(params[:inventory_object])
    @inventory_object.id1 = nil
    render 'tag'
  end
  
  def lookup
	if params[:loanee] then
		@loanee = Loanee.find(params[:loanee][:loanee_token])
	else
		#render form
		@loanee = Loanee.new
	end
  end
end
