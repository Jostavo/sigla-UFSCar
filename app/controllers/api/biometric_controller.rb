class Api::BiometricController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create_access
    respond_to do |format|
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
      @biometric = Biometric.new(:hash_biometric => params[:hash_biometric])
      if @biometric.save
        format.json { render json: @biometric }
      else
        format.json { render json: @biometric.errors.as_json }
      end
    end
  end

  def get
    respond_to do |format|
      @person_biometric = AuthorizedPerson.where(biometric_authorized_params).select(:user_id, :biometric)
      format.json { render json: @person_biometric }
    end
  end

  private
  def biometric_authorized_params
    params.permit(:laboratory_id)
  end

  private
  def biometric_params
    params.permit(:hash_biometric)
  end

  private
  def biometric_access_params
    params.permit(:laboratory_id, :user_id)
  end
end
