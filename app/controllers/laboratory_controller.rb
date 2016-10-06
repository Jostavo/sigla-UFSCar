class LaboratoryController < ApplicationController
  def show
    if params[:initials] != nil
      @labs = Laboratory.find_by(:initials => params[:initials])
    else
      @labs = Laboratory.find_by(:initials => "LSO")
    end
    @status = @labs.status.last
    @subjects = @labs.subjects
  end

  def map
    render html: "hello world, #laboratory#map"
  end
end
