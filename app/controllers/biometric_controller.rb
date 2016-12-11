class BiometricController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create_access
    respond_to do |format|
      puts biometric_access_params
      @biometric_access = BiometricAccess.new(biometric_access_params)
      if @biometric_access.save
        format.json { render json: @biometric_access }
      else
        format.json { render json: @biometric_access.error.as_json }
      end
    end
  end

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
      if Time.now - @biometric.created_at <= 60
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

  private
  def biometric_access_params
    params.permit(:laboratory_id, :user_id)
  end
end
