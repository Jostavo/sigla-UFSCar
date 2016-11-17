class ReportController < ApplicationController
  def create
    params = report_params
    @laboratory = Laboratory.find_by(:initials => params[:laboratory_initials])
    @computer = @laboratory.computers.find_by(:physical_id => params[:computer_id])
    @report = @computer.reports.new(:description => params[:description], :user_id => current_user.id, :laboratory_id => @laboratory.id, :laboratory_initials => @laboratory.initials)

    if @report.save
      flash.notice = "Report salvo!"
      redirect_to root_path
    else
      flash.alert= "Não foi possível salvar o report! #{@report.errors}"
      redirect_to root_path
    end
  end

  private
  def report_params
    params.require(:report).permit(:computer_id, :laboratory_initials, :description)
  end
end
