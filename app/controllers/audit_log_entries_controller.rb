class AuditLogEntriesController < ApplicationController
  # GET /audit_log_entries
  # GET /audit_log_entries.json
  def index
    @audit_log_entries = AuditLogEntry.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @audit_log_entries }
    end
  end

  # GET /audit_log_entries/1
  # GET /audit_log_entries/1.json
  def show
    @audit_log_entry = AuditLogEntry.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @audit_log_entry }
    end
  end

  # GET /audit_log_entries/new
  # GET /audit_log_entries/new.json
  def new
    @audit_log_entry = AuditLogEntry.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @audit_log_entry }
    end
  end

  # GET /audit_log_entries/1/edit
  def edit
    @audit_log_entry = AuditLogEntry.find(params[:id])
  end

  # POST /audit_log_entries
  # POST /audit_log_entries.json
  def create
    @audit_log_entry = AuditLogEntry.new(params[:audit_log_entry])

    respond_to do |format|
      if @audit_log_entry.save
        format.html { redirect_to @audit_log_entry, notice: 'Audit log entry was successfully created.' }
        format.json { render json: @audit_log_entry, status: :created, location: @audit_log_entry }
      else
        format.html { render action: "new" }
        format.json { render json: @audit_log_entry.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /audit_log_entries/1
  # PUT /audit_log_entries/1.json
  def update
    @audit_log_entry = AuditLogEntry.find(params[:id])

    respond_to do |format|
      if @audit_log_entry.update_attributes(params[:audit_log_entry])
        format.html { redirect_to @audit_log_entry, notice: 'Audit log entry was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @audit_log_entry.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /audit_log_entries/1
  # DELETE /audit_log_entries/1.json
  def destroy
    @audit_log_entry = AuditLogEntry.find(params[:id])
    @audit_log_entry.destroy

    respond_to do |format|
      format.html { redirect_to audit_log_entries_url }
      format.json { head :no_content }
    end
  end
end
