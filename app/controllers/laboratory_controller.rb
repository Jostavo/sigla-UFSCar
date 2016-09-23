class LaboratoryController < ApplicationController
  def show
    if params[:initials] != nil
      @labs = Laboratory.find_by(:initials => params[:initials])
    else
      @labs = Laboratory.find_by(:initials => "LSO")
    end
    @status = @labs.status.last
    @subjects = @labs.subjects
    if @status == nil
      #redirect_to root_path
    end
  end
end
