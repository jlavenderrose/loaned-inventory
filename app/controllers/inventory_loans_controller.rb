class InventoryLoansController < ApplicationController
  # GET /inventory_loans
  # GET /inventory_loans.json
  def index
	unless params[:open].present? then
		@inventory_loans = InventoryLoan.all
	else
		@inventory_loans = InventoryLoan.open.all
	end
    

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @inventory_loans }
      format.csv { render :csv => @inventory_loans,
						  :filename => "inventory_loans.csv" }
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
        format.html {
			if params[:inventory_loan][:loanee_token] or params[:inventory_loan][:inventory_object_token] then
				if params[:inventory_loan][:loanee_id] then
					redirect_to @inventory_loan.loanee, notice: 'Inventory loan was successfully created.' 
				elsif params[:inventory_loan][:inventory_object_id] then
					redirect_to @inventory_loan.inventory_object, notice: 'Inventory loan was successfully created.' 
				else
					redirect_to @inventory_loan, notice: 'Inventory loan was successfully created.' 
				end
			else
				redirect_to @inventory_loan, notice: 'Inventory loan was successfully created.' 
			end
		}
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
    #@inventory_loan.destroy don't do this
    if @inventory_loan.current? then
      @inventory_loan.returned_date = Date.today
      @inventory_loan.save
    end
    

    respond_to do |format|
      format.html { 
        if params[:lookup].present? then
          redirect_to point_of_sale_lookup_path(:loanee => {:loanee_token => @inventory_loan.loanee.id}),
            notice: @inventory_loan.current? ? "Loan closed" : nil
        else
          redirect_to inventory_loans_url 
        end
      }
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
