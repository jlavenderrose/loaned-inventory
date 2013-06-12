class LoaneesController < ApplicationController
  # GET /loanees
  # GET /loanees.json
  def index
    @loanees = Loanee.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @loanees }
    end
  end

  # GET /loanees/1
  # GET /loanees/1.json
  def show
    @loanee = Loanee.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @loanee }
    end
  end

  # GET /loanees/new
  # GET /loanees/new.json
  def new
    @loanee = Loanee.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @loanee }
    end
  end

  # GET /loanees/1/edit
  def edit
    @loanee = Loanee.find(params[:id])
  end

  # POST /loanees
  # POST /loanees.json
  def create
    @loanee = Loanee.new(params[:loanee])

    respond_to do |format|
      if @loanee.save
        format.html { redirect_to @loanee, notice: 'Loanee was successfully created.' }
        format.json { render json: @loanee, status: :created, location: @loanee }
      else
        format.html { render action: "new" }
        format.json { render json: @loanee.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /loanees/1
  # PUT /loanees/1.json
  def update
    @loanee = Loanee.find(params[:id])

    respond_to do |format|
      if @loanee.update_attributes(params[:loanee])
        format.html { redirect_to @loanee, notice: 'Loanee was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @loanee.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /loanees/1
  # DELETE /loanees/1.json
  def destroy
    @loanee = Loanee.find(params[:id])
    @loanee.destroy

    respond_to do |format|
      format.html { redirect_to loanees_url }
      format.json { head :no_content }
    end
  end
end
