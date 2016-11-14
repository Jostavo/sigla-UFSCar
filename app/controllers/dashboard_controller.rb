class DashboardController < ApplicationController
  # remove standard layout
  layout "dashboard"
  before_action :authenticate_user!, :isAdmin

  def show
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
