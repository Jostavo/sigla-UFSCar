class LaboratoryController < ApplicationController
  def show
    if params[:id] != nil
      @labs = Laboratory.find_by(:id => params[:id]) || Laboratory.find_by(:initials => params[:id])
    else
      @labs = Laboratory.find_by(:initials => "LSO")
    end
    @status = @labs.status.last
    @computers = @labs.computers.order(physical_id: "ASC")

    if user_signed_in?
      @report = Report.new
    end
  end

  def map
    render html: "hello world, #laboratory#map"
  end

  def subjects
    @labs = Laboratory.find_by(:initials => params[:initials])
    @subjects = @labs.subjects.today_with_hash
    render :layout => false
  end
end
