require 'csv'

class InventoryObjectsController < ApplicationController
  include FullTextQuery
  #tagging autocompletion
  autocomplete :tag, :name, :class_name => 'ActsAsTaggableOn::Tag'
  
  # GET /inventory_objects
  # GET /inventory_objects.json
  def index
    @inventory_objects = []
    @search = {versionid: 0}
    filename = "blank"
    if params[:q].present? then
      @inventory_objects = array_wrap InventoryObject.new.search(params[:q])
      @inventory_objects += array_wrap InventoryObject.tagged_with(params[:q].downcase)
      
      @search = {idnum: params[:q]}
      filename = params[:q].gsub(/[^A-z0-9]/,'_')
    end
    
    if params[:search] then
		unless params[:search][:versionid].to_i == 0 then
			logger.debug "Adv. Search: By InventoryObjectVersion"
			version = InventoryObjectVersion.find(params[:search][:versionid]) if params[:search][:versionid]
			base = version.objects if version
			base = InventoryObject unless base
		else
			logger.debug "Adv. Search: By ALL"
			base = InventoryObject
		end
		
		logger.debug "Selecting by tag" if params[:search][:tags].present?
		base = base.tagged_with(params[:search][:tags].split ", ") if params[:search][:tags].present?
		
		if params[:search][:idnum].present? then
			logger.debug "Selecting by idnum"
			base = like_query(base, {'id1' => params[:search][:idnum],
									 'id2' => params[:search][:idnum],
									 'id3' => params[:search][:idnum]})
		end
										
		if base.respond_to? "all" then
			@inventory_objects = base.all 
		else
			@inventory_objects = base
		end
		
		@search = params[:search]
		"#{params[:search][:idnum]} #{params[:search][:version_id]} #{params[:search][:tags]}".gsub(/[^A-z0-9]/,'_')
    end

    logger.debug @search
    respond_to do |format|
      format.html {
        if @inventory_objects.count == 1 then
          redirect_to @inventory_objects.first
        else
          render
        end
      }
      #jQuery TokenInput support
      format.json { 
        render :json => @inventory_objects
      }
      #CSV support
      format.csv {
        render :csv => @inventory_objects,
               :filename => "inventory_object_search_#{filename}"
      }
      end
  end
  
  def array_wrap (obj)
    if obj.respond_to?('count')
      obj
    else
      [obj]
    end
  end

  # GET /inventory_objects/1
  # GET /inventory_objects/1.json
  def show
    @inventory_object = InventoryObject.find(params[:id])
    
    @report_entry = @inventory_object.report_entries.new
    @report_entry.inventory_object_ids = [@inventory_object.id]
    @report_entry.administrator = current_user

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @inventory_object }
    end
  end

  # GET /inventory_objects/new
  # GET /inventory_objects/new.json
  def new
    @inventory_object = InventoryObject.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @inventory_object }
    end
  end

  # GET /inventory_objects/1/edit
  def edit
    @inventory_object = InventoryObject.find(params[:id])
  end

  # POST /inventory_objects
  # POST /inventory_objects.json
  def create
    @inventory_object = InventoryObject.new(params[:inventory_object])

    respond_to do |format|
      if @inventory_object.save
        format.html { redirect_to @inventory_object, notice: 'Inventory object was successfully created.' }
        format.json { render json: @inventory_object, status: :created, location: @inventory_object }
      else
        format.html { render action: "new" }
        format.json { render json: @inventory_object.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /inventory_objects/1
  # PUT /inventory_objects/1.json
  def update
    @inventory_object = InventoryObject.find(params[:id])

    respond_to do |format|
      if @inventory_object.update_attributes(params[:inventory_object])
        format.html { redirect_to @inventory_object, notice: 'Inventory object was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @inventory_object.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /inventory_objects/1
  # DELETE /inventory_objects/1.json
  def destroy
    @inventory_object = InventoryObject.find(params[:id])
    @inventory_object.destroy

    respond_to do |format|
      format.html { redirect_to inventory_objects_url }
      format.json { head :no_content }
    end
  end
  
  #CSV export
  def export
    respond_to do |format|
      format.csv { render :csv => InventoryObject.all,
                          :filename => "inventory_full.csv" }
    end
  end
  
  #CSV import
  def import
  end
  
  def upload
	if params[:csv] then
		csv = CSV.new(params[:csv].read, :headers => :true,
					 :header_converters=> lambda {|f| f.strip.downcase},
				     :converters=> lambda {|f| f ? f.strip : nil})
		@good = []
		@bad = []
		csv.each do |row|
				#Type Version Id1 Id2 Id3
				if (row['id1'] || row['id2'] || row['id3']) then
					version = 0
					unless row['type'].nil? then
							type = InventoryObjectType.new.findcreate(row['type'])
							version = type.versions.findcreate(row['version'])
						else
							version = InventoryObjectVersion.find_by_name(row['version'])
					end
					if version then
						object = version.objects.create(id1: row['id1'], id2: row['id2'], id3: row['id3'])
						
						@good << {:row => row, :errors => object.errors} if object.valid?
						@bad << {:row => row, :errors => object.errors} unless object.valid?
					else
						@bad << {:row => row, :errors => ["version", "does not exist"]}
					end
			end
		end
	end
  end
end
