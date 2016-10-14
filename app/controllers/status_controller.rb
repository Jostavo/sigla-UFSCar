class StatusController < ApplicationController
  skip_before_action :verify_authenticity_token

  def new_laboratory
    respond_to do |format|
      @lab = Laboratory.find_by(:initials => params[:lab_tag])
      puts @lab.id
      @status = Status.new(laboratory_id: @lab.id, isOpen: params[:isOpen])
      if @status.save
        format.json { render json: @status }
      else
        format.json { render json: @status.errors.as_json }
      end
    end
  end

  def new_computer
    respond_to do |format|
      @lab = Laboratory.find_by(:initials => params[:initials])

      if @lab == nil
        output = "this lab does not exist"
        format.json { render json: output.to_json }
        return
      end

      @computer = @lab.computers.find_by(:physical_id => params[:computer_id])

      if @computer == nil
        format.json { render json: {'error'=>'this computer does not exist.'}.to_json }
        return
      else
        puts "entrada1"
        @computer_status = @computer.computer_status.new(:status => params[:status])
      end

      if @computer_status.save
        @computer.update(:status => params[:status], :updated_at => Time.now)
        format.json { render json: @computer_status }
      else
        format.json { render json: @computer_status.errors.as_json }
      end
    end
  end

  private
  def status_params
    params.require[:status].permit(:laboratory_id, :lab_tag, :isOpen)
  end

end
