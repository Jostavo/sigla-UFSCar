class AuthorizedPersonController < ApplicationController

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

  def save
    @authorized_person = AuthorizedPerson.new(authorized_person_params)
    if @authorized_person.save
      @authorized_person.laboratory.update_attributes(:embedded_update => true)
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
  def authorized_person_params_delete
    params.require(:authorized_person).permit(:user_id, :laboratory_id, :biometric)
  end

  private
  def authorized_person_params
    params.require(:authorized_person).permit(:user_id, :laboratory_id, :biometric)
  end
end
