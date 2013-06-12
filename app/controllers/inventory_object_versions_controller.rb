class InventoryObjectVersionsController < ApplicationController
  # GET /inventory_object_versions
  # GET /inventory_object_versions.json
  def index
    @inventory_object_versions = InventoryObjectVersion.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @inventory_object_versions }
    end
  end

  # GET /inventory_object_versions/1
  # GET /inventory_object_versions/1.json
  def show
    @inventory_object_version = InventoryObjectVersion.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @inventory_object_version }
    end
  end

  # GET /inventory_object_versions/new
  # GET /inventory_object_versions/new.json
  def new
    @inventory_object_version = InventoryObjectVersion.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @inventory_object_version }
    end
  end

  # GET /inventory_object_versions/1/edit
  def edit
    @inventory_object_version = InventoryObjectVersion.find(params[:id])
  end

  # POST /inventory_object_versions
  # POST /inventory_object_versions.json
  def create
    @inventory_object_version = InventoryObjectVersion.new(params[:inventory_object_version])

    respond_to do |format|
      if @inventory_object_version.save
        format.html { redirect_to @inventory_object_version, notice: 'Inventory object version was successfully created.' }
        format.json { render json: @inventory_object_version, status: :created, location: @inventory_object_version }
      else
        format.html { render action: "new" }
        format.json { render json: @inventory_object_version.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /inventory_object_versions/1
  # PUT /inventory_object_versions/1.json
  def update
    @inventory_object_version = InventoryObjectVersion.find(params[:id])

    respond_to do |format|
      if @inventory_object_version.update_attributes(params[:inventory_object_version])
        format.html { redirect_to @inventory_object_version, notice: 'Inventory object version was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @inventory_object_version.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /inventory_object_versions/1
  # DELETE /inventory_object_versions/1.json
  def destroy
    @inventory_object_version = InventoryObjectVersion.find(params[:id])
    @inventory_object_version.destroy

    respond_to do |format|
      format.html { redirect_to inventory_object_versions_url }
      format.json { head :no_content }
    end
  end
end
