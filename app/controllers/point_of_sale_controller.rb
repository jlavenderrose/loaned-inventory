class PointOfSaleController < ApplicationController
  autocomplete :loanee, :total_id
  
  def create
	@point_of_sale = true
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
  
  def search
	if params[:q] then
		loanees = array_wrap Loanee.search(params[:q])
		objects = array_wrap InventoryObject.search(params[:q])
		@results = loanees + objects
	else
		@results = []
	end
	
	respond_to do |format|
		format.json {
			render json: @results
		}
	end
  end
  
  def find
	begin
		if params[:pos_token].include? "l" then
			loanee = Loanee.find(params[:pos_token].gsub(/[A-z]/,'').to_i)
			redirect_to loanee
		elsif params[:pos_token].include? "o" then
			inventory_object = InventoryObject.find(params[:pos_token].gsub(/[A-z]/,'').to_i)
			redirect_to inventory_object
		else
			redirect_to root_path, notice: "No such record was located"
		end
	rescue RecordNotFound
		redirect_to root_path, notice: "No such record was located"
	end
  end
  
  def tag
	@inventory_object = InventoryObject.new
	if params[:inventory_object] then
		if params[:inventory_object][:inventory_object_token] then
			inventory_object = InventoryObject.find_by_id(params[:inventory_object][:inventory_object_token])
			if inventory_object.present? then
				inventory_object.status_tag_list += params[:inventory_object][:status_tag_list].split(", ")
				inventory_object.save
				flash[:notice] = "Tagged Inventory Object #{inventory_object.id1}" if inventory_object
			end
		end
		
		if params[:inventory_object][:status_tag_list].present? then
			@inventory_object.status_tag_list = params[:inventory_object][:status_tag_list]
		end
	end
	#render page
  end
  
  def array_wrap (obj)
    if obj.respond_to?('count')
      obj
    else
      [obj]
    end
  end
end
