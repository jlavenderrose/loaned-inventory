class InventoryObjectTypesController < ApplicationController
  # GET /inventory_object_types
  # GET /inventory_object_types.json
  def index
    @inventory_object_types = InventoryObjectType.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @inventory_object_types }
    end
  end

  # GET /inventory_object_types/1
  # GET /inventory_object_types/1.json
  def show
    @inventory_object_type = InventoryObjectType.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @inventory_object_type }
    end
  end

  # GET /inventory_object_types/new
  # GET /inventory_object_types/new.json
  def new
    @inventory_object_type = InventoryObjectType.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @inventory_object_type }
    end
  end

  # GET /inventory_object_types/1/edit
  def edit
    @inventory_object_type = InventoryObjectType.find(params[:id])
  end

  # POST /inventory_object_types
  # POST /inventory_object_types.json
  def create
    @inventory_object_type = InventoryObjectType.new(params[:inventory_object_type])

    respond_to do |format|
      if @inventory_object_type.save
        format.html { redirect_to @inventory_object_type, notice: 'Inventory object type was successfully created.' }
        format.json { render json: @inventory_object_type, status: :created, location: @inventory_object_type }
      else
        format.html { render action: "new" }
        format.json { render json: @inventory_object_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /inventory_object_types/1
  # PUT /inventory_object_types/1.json
  def update
    @inventory_object_type = InventoryObjectType.find(params[:id])

    respond_to do |format|
      if @inventory_object_type.update_attributes(params[:inventory_object_type])
        format.html { redirect_to @inventory_object_type, notice: 'Inventory object type was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @inventory_object_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /inventory_object_types/1
  # DELETE /inventory_object_types/1.json
  def destroy
    @inventory_object_type = InventoryObjectType.find(params[:id])
    @inventory_object_type.destroy

    respond_to do |format|
      format.html { redirect_to inventory_object_types_url }
      format.json { head :no_content }
    end
  end
end
