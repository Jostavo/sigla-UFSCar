class LaboratoryController < ApplicationController
  def show
    if params[:initials] != nil
      @labs = Laboratory.find_by(:initials => params[:initials])
    else
      @labs = Laboratory.find_by(:initials => "LSO")
    end
    @status = @labs.status.last
    @computers = @labs.computers
  end

  def map
    render html: "hello world, #laboratory#map"
  end

  def subjects
    @labs = Laboratory.find_by(:initials => params[:initials])
    @subjects = @labs.subjects
    render :layout => false
  end
end