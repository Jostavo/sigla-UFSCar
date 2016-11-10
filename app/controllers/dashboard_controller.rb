class DashboardController < ApplicationController
  # remove standard layout
  layout false, only: [:show]
  def show
  end
end
