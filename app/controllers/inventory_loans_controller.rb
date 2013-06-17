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

  #CSV export
  def export
    respond_to do |format|
      format.csv { render :csv => InventoryLoan.all,
                          :filename => "inventory_loan_all.csv" }
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
			object = InventoryLoan.create(loanee_name: row['loanee'],
										  inventory_object_name: row['inventory object'])
			
			@good << {row: row, errors: object.errors} if object.valid?
			@bad << {row: row, errors: object.errors} unless object.valid?
		end
	end
  end
end
