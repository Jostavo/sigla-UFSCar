class StatusController < ApplicationController
  skip_before_action :verify_authenticity_token

  def new
    respond_to do |format|
      @lab = Laboratory.find_by(:initials => params[:lab_tag])
#      if(@lab == nil)
#        render
#      end
      puts @lab.id
      @status = Status.new(laboratory_id: @lab.id, isOpen: params[:isOpen])
      if @status.save
        format.json { render json: @status }
      else
        format.json { render json: @status.errors.as_json }
      end
    end
  end

  private
  def status_params
    params.require[:status].permit(:laboratory_id, :lab_tag, :isOpen)
  end


end
