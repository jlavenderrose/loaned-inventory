class AdministratorsController < ApplicationController
  # GET /administrators
  # GET /administrators.json
  def index
    @administrators = Administrator.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @administrators }
    end
  end

  # GET /administrators/1
  # GET /administrators/1.json
  def show
    @administrator = Administrator.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @administrator }
    end
  end

  # GET /administrators/new
  # GET /administrators/new.json
  def new
    @administrator = Administrator.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @administrator }
    end
  end

  # GET /administrators/1/edit
  def edit
    @administrator = Administrator.find(params[:id])
  end

  # POST /administrators
  # POST /administrators.json
  def create
    @administrator = Administrator.new(params[:administrator])

    respond_to do |format|
      if @administrator.save
        format.html { redirect_to @administrator, notice: 'Administrator was successfully created.' }
        format.json { render json: @administrator, status: :created, location: @administrator }
      else
        format.html { render action: "new" }
        format.json { render json: @administrator.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /administrators/1
  # PUT /administrators/1.json
  def update
    @administrator = Administrator.find(params[:id])

    respond_to do |format|
      if @administrator.update_attributes(params[:administrator])
        format.html { redirect_to @administrator, notice: 'Administrator was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @administrator.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /administrators/1
  # DELETE /administrators/1.json
  def destroy
    @administrator = Administrator.find(params[:id])
    @administrator.destroy

    respond_to do |format|
      format.html { redirect_to administrators_url }
      format.json { head :no_content }
    end
  end
end
