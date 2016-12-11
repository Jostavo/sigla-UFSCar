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
    @labopen_week = Laboratory.find_by(:initials => "LSO").status.average_this_week
    #Tempo médio que ficou aberto semana passada
    @labopen_last_week = Laboratory.find_by(:initials => "LSO").status.average_last_week
    #Número de usuários cadastrados no sistema
    @users_count = User.all.count
    #Número de Reports não resolvidos
    @reports_pending = Report.where(:resolution => "pending").count + Report.where(:resolution => "verifying").count
    #Número total de reports
    @total_reports = Report.all.count
    #Tempo sem energia essa semana  #fica pra próxima
    #Tempo sem energia semana passada #fica pra próxima
    #5 salas com mais aulas
    @top5_labs = top5_labs
    #Últimos 4 reports de máquinas (e o horário que foram feitos)
    @last_4_reports = Report.last(4).reverse
    #Últimos 5 acessos ao LERIS
    @biometric_access = BiometricAccess.last(5).reverse

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
    @report = Report.where(:laboratory_initials => @laboratory.initials).order(created_at: "desc")
    @report_edit = Report.new
  end

  def map
    @laboratory = Laboratory.find_by(:initials => params[:initials])
    @computers = @laboratory.computers.order(physical_id: "ASC")
  end

  def statistics
    @laboratory = Laboratory.find_by(:initials => params[:initials])
  end

  def embedded
    @laboratory = Laboratory.find_by(:initials => params[:initials])
  end

  def access
    @user = User.all.order(id: "ASC")
    @laboratory = Laboratory.find_by(:initials => params[:initials])
    @authorized_people = @laboratory.authorized_people
    @access_people = BiometricAccess.where(:laboratory_id => @laboratory.id).sort_by(&:created_at)
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

  # temporary solution
  private
  def top5_labs
    lab = Laboratory.all
    hash_labs = Hash.new

    lab.each do |l|
      hash_labs[l.initials] = l.subjects.count
    end
    hash_labs.sort
  end


end
