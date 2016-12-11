class AuthorizedPersonController < ApplicationController
 skip_before_action :verify_authenticity_token, only: [:get]

  def get
    respond_to do |format|
      @person_biometric = AuthorizedPerson.where(authorized_person_params_get).select(:user_id, :biometric)
      format.json { render json: @person_biometric }
    end
  end

  def save
    @authorized_person = AuthorizedPerson.new(authorized_person_params)
    if @authorized_person.save
      flash.notice = "Autorização Concedida!"
      redirect_to :back
    else
      flash.alert= "Não foi possível realizar a autorização!"
      redirect_to :back
    end
  end

  def delete
    params_delete = authorized_person_params_delete
    AuthorizedPerson.where(:user_id => params_delete[:user_id]).where(:laboratory_id => params_delete[:laboratory_id])[0].delete
    flash.notice = "Autorização revogada!"
    redirect_to :back
  end

  private
  def authorized_person_params_get
    params.permit(:laboratory_id)
  end

  private
  def authorized_person_params_delete
    params.require(:authorized_person).permit(:user_id, :laboratory_id, :biometric)
  end

  private
  def authorized_person_params
    params.require(:authorized_person).permit(:user_id, :laboratory_id, :biometric)
  end
end
