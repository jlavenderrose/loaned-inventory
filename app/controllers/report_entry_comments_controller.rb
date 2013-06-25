class ReportEntryCommentsController < ApplicationController
	def create
		@report_entry_comment = ReportEntryComment.new(params[:report_entry_comment])
		
		if @report_entry_comment.save then
			redirect_to @report_entry_comment.report_entry.path_object
		else
			if @report_entry_comment.report_entry then
				redirect_to @report_entry_comment.report_entry.path_object, 
					notice: "Failed to create ReportEntryComment"
			else
				redirect_to :back
			end
		end
	end
end
