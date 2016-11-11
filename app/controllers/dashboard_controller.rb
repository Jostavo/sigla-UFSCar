class DashboardController < ApplicationController
  # remove standard layout
  layout false, only: [:show]
  before_action :authenticate_user!

  def show
    if current_user.isAdmin?
      # true
    else
      redirect_to root_path
    end
  end

end
