class Api::BiometricController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create_access
    respond_to do |format|
      param = biometric_access_params
      @lab = Laboratory.find_by(:embedded_password => param[:embedded_password])

      if !@lab
        format.json { render :json => { :errors => "access denied" }, :status => 203 }
      else
        @person = AuthorizedPerson.find_by(:user_id => param[:user_id])
        if !@person
          #@lab.update_attributes(:embedded_update => true)
          format.json { render :json => { :embedded_update => @lab.embedded_update } }
        else
          @biometric_access = BiometricAccess.new(:laboratory_id => @lab.id, :user_id => param[:user_id])
          if @biometric_access.save
            format.json { render :json => { :embedded_update => @lab.embedded_update} }
          else
            format.json { render json: @biometric_access.error.as_json }
          end
        end
      end
    end
  end

  def create
    respond_to do |format|
      param = biometric_params
      @lab = Laboratory.find_by(:embedded_password => param[:embedded_password])
      if !@lab
        format.json { render json => { :errors => "access denied" }, :status => 203 }
      else
        @biometric = Biometric.new(:hash_biometric => params[:hash_biometric])
        if @biometric.save
          format.json { render json: @biometric }
        else
          format.json { render json: @biometric.errors.as_json }
        end
      end
    end
  end

  def get
    respond_to do |format|
      param = biometric_authorized_params
      @lab = Laboratory.find_by(:embedded_password => param[:embedded_password])
      if !@lab
        format.json { render :json => {:user_id => "-1", :biometric => "-1"}, :status => 203 }
      else
        @lab.update_attributes(:embedded_update => false)
        @person_biometric = AuthorizedPerson.where(:laboratory_id => @lab.id).select(:user_id, :biometric)
        format.json { render json: @person_biometric }
      end
    end
  end

  private
  def biometric_authorized_params
    params.permit(:embedded_password)
  end

  private
  def biometric_params
    params.permit(:embedded_password, :hash_biometric)
  end

  private
  def biometric_access_params
    params.permit(:embedded_password, :user_id)
  end
end
