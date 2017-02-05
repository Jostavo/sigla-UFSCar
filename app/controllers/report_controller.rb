class ReportController < LaboratoryController
  before_action :authenticate_user!

  def show
    @labs = Laboratory.find_by(:id => params[:laboratory_id]) || Laboratory.find_by(:initials => params[:laboratory_id])
    @report = Report.where(:user_id => current_user.id,:laboratory_id => @labs.id).order(created_at: :desc)
  end

  def create
    params = report_params
    @laboratory = Laboratory.find_by(:initials => params[:laboratory_initials])
    @computer = @laboratory.computers.find_by(:physical_id => params[:computer_id])
    @report = @computer.reports.new(:description => params[:description], :user_id => current_user.id, :user_name => current_user.name, :laboratory_id => @laboratory.id, :laboratory_initials => @laboratory.initials)

    if @report.save
      redirect_to laboratory_path(@laboratory)
      flash.notice = "Report salvo!"
    else
      flash.alert= "Não foi possível salvar o report! #{@report.errors}"
      redirect_to laboratory_path(@laboratory)
    end
  end

  def edit
    id = params[:report_id_]
    commit = params[:commit]
    edit_params = report_params_edit_dashboard

    @report = Report.find_by(:id => id[0])
    if @report.update_attributes(:solution => edit_params[:solution], :resolution => commit)
      computer = Computer.find_by(:id => @report.computer_id)
      if (commit == "verifying")
        computer.update_attributes(:status => "maintenance")
      elsif (commit == "resolved")||(commit == "pending")
        computer.update_attributes(:status => "busy")
      end
      flash.notice = "Report editado!"
      redirect_to :back
    else
      flash.alert = "Não foi possível editar o report! #{@report.errors}"
      redirect_to :back
    end
  end

  private
  def report_params_edit_dashboard
    params.require(:report).permit(:id, :solution)
  end

  private
  def report_params
    params.require(:report).permit(:computer_id, :laboratory_initials, :description)
  end
end
