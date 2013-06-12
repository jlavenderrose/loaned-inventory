class InventoryLoansController < ApplicationController
  # GET /inventory_loans
  # GET /inventory_loans.json
  def index
    @inventory_loans = InventoryLoan.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @inventory_loans }
    end
  end

  # GET /inventory_loans/1
  # GET /inventory_loans/1.json
  def show
    @inventory_loan = InventoryLoan.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @inventory_loan }
    end
  end

  # GET /inventory_loans/new
  # GET /inventory_loans/new.json
  def new
    @inventory_loan = InventoryLoan.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @inventory_loan }
    end
  end

  # GET /inventory_loans/1/edit
  def edit
    @inventory_loan = InventoryLoan.find(params[:id])
  end

  # POST /inventory_loans
  # POST /inventory_loans.json
  def create
    @inventory_loan = InventoryLoan.new(params[:inventory_loan])

    respond_to do |format|
      if @inventory_loan.save
        format.html { redirect_to @inventory_loan, notice: 'Inventory loan was successfully created.' }
        format.json { render json: @inventory_loan, status: :created, location: @inventory_loan }
      else
        format.html { render action: "new" }
        format.json { render json: @inventory_loan.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /inventory_loans/1
  # PUT /inventory_loans/1.json
  def update
    @inventory_loan = InventoryLoan.find(params[:id])

    respond_to do |format|
      if @inventory_loan.update_attributes(params[:inventory_loan])
        format.html { redirect_to @inventory_loan, notice: 'Inventory loan was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @inventory_loan.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /inventory_loans/1
  # DELETE /inventory_loans/1.json
  def destroy
    @inventory_loan = InventoryLoan.find(params[:id])
    @inventory_loan.destroy

    respond_to do |format|
      format.html { redirect_to inventory_loans_url }
      format.json { head :no_content }
    end
  end
end
