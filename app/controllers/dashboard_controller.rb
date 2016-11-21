class DashboardController < ApplicationController
  # remove standard layout
  layout "dashboard"
  before_action :authenticate_user!, :isAdmin

  def show
    @report = Report.group(:computer_id).count().sort_by{|k,v| v}.reverse
  #Tempo aberto no dia atual
    @labopen_today = Laboratory.find_by(:initials => "LSO").status.today_open_in_seconds
  #Tempo aberto no mesmo dia, só que 1 semana atrás
    @labopen_today_and_week_ago = Laboratory.find_by(:initials => "LSO").status.last_week_open_in_seconds
  #Tempo médio que ficou aberto essa semana
  #Tempo médio que ficou aberto semana passada
  #Número de usuários cadastrados no sistema
  #Número de Reports não resolvidos
  #Número total de reports
  #Tempo sem energia essa semana
  #Tempo sem energia semana passada
  #5 salas com mais aulas
  #Últimos 4 reports de máquinas (e o horário que foram feitos)
  #Últimos 4 acessos ao LERIS -->
  end

  def profile
    @user = current_user
  end

  def edit
    @user = User.find_by(:email => current_user.email)
    params = user_params
    if params[:current_password] != @user.password
      render html: "no donut 4u"
      return
    end
    if params[:password_confirmation].empty?
      # only updates name, email
      @user.update(:name => params[:name], :email => params[:email])
    else
      if params[:password] == params[:password_confirmation]
        @user.update(:name => params[:name], :email => params[:email], :password => params[:password], :password_confirmation => params[:password_confirmation])
      end
    end
  end

  def help
  end

  def report
    @laboratory = Laboratory.find_by(:initials => params[:initials])
    @report = Report.where(:laboratory_initials => @laboratory.initials).reverse
    @report_edit = Report.new
  end

  def map
    @laboratory = Laboratory.find_by(:initials => params[:initials])
  end

  def statistics
    @laboratory = Laboratory.find_by(:initials => params[:initials])
  end

  def embedded
    @laboratory = Laboratory.find_by(:initials => params[:initials])
  end

  def access
    @laboratory = Laboratory.find_by(:initials => params[:initials])
  end

  # if user is a admin, the user is allowed to access the dashboard
  private
  def isAdmin
    if current_user.isAdmin?
      # true
    else
      redirect_to root_path
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :current_password)
  end

end
