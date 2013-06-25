class ReportEntriesController < ApplicationController
  # GET /report_entries
  # GET /report_entries.json
  def index
	unless params[:q].nil?
		@report_entries = ReportEntry.search params[:q]
	else
		@report_entries = []
	end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @report_entries }
    end
  end

  # GET /report_entries/1
  # GET /report_entries/1.json
  def show
    @report_entry = ReportEntry.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @report_entry }
    end
  end

  # GET /report_entries/new
  # GET /report_entries/new.json
  def new
    @report_entry = ReportEntry.new
    @report_entry.administrator = current_user

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @report_entry }
    end
  end

  # GET /report_entries/1/edit
  def edit
    @report_entry = ReportEntry.find(params[:id])
  end

  # POST /report_entries
  # POST /report_entries.json
  def create
    @report_entry = ReportEntry.new(params[:report_entry])

    respond_to do |format|
      if @report_entry.save
        format.html { 
          if @report_entry.inventory_objects.count > 1 then
            redirect_to @report_entry, notice: 'Report entry was successfully created.' 
          else
            redirect_to @report_entry.inventory_objects.first, notice: 'Report entry was successfully created.' 
          end
        }
        format.json { render json: @report_entry, status: :created, location: @report_entry }
      else
        format.html { render action: "new" }
        format.json { render json: @report_entry.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /report_entries/1
  # PUT /report_entries/1.json
  def update
    @report_entry = ReportEntry.find(params[:id])

    respond_to do |format|
      if @report_entry.update_attributes(params[:report_entry])
        format.html { redirect_to @report_entry, notice: 'Report entry was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @report_entry.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /report_entries/1
  # DELETE /report_entries/1.json
  def destroy
    @report_entry = ReportEntry.find(params[:id])
    @report_entry.destroy

    respond_to do |format|
      format.html { redirect_to report_entries_url }
      format.json { head :no_content }
    end
  end
end
