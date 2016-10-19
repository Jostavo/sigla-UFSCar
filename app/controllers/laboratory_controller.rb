class LaboratoryController < ApplicationController
  def show
    if params[:initials] != nil
      @labs = Laboratory.find_by(:initials => params[:initials])
    else
      @labs = Laboratory.find_by(:initials => "LSO")
    end
    @status = @labs.status.last
<<<<<<< HEAD
    @subjects = @labs.subjects
    if @status == nil
      #redirect_to root_path
    end
=======
    @computers = @labs.computers
  end

  def map
    render html: "hello world, #laboratory#map"
>>>>>>> 73fec0d... Changed frontpage, create a new route for iframe
  end

  def subjects
    @labs = Laboratory.find_by(:initials => params[:initials])
    @subjects = @labs.subjects
    render :layout => false
  end
end
