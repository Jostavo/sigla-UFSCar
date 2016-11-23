class BiometricController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    respond_to do |format|
      @biometric = Biometric.new(biometric_params)

      if @biometric.save
        format.json { render json: @biometric }
      else
        format.json { render json: @biometric.errors.as_json }
      end
    end
  end

  def get_biometric
    respond_to do |format|
      @biometric = Biometric.last
      if Time.now - @biometric.created_at <= 6000
        format.json { render json: @biometric }
      else
        format.json { render json: @biometric.errors.as_json }
      end
    end
  end

  private
  def biometric_params
    params.require[:biometric].permit(:hash)
  end


end
