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
      @authorized_person.update_attributes(:status => "authorized")
      @authorized_person.laboratory.update_attributes(:embedded_update => true)
      flash.notice = "Autorização Concedida!"
      redirect_to :back
    else
      flash.alert= "Não foi possível realizar a autorização!"
      redirect_to :back
    end
  end

  def extend
    params_delete = authorized_person_control
    Laboratory.find_by(:id => params_delete[:laboratory_id]).update_attributes(:embedded_update => true)
    AuthorizedPerson.where(:user_id => params_delete[:user_id], :laboratory_id => params_delete[:laboratory_id])[0].update_attributes(:status => "authorized", :created_at => DateTime.now)
    flash.notice = "Autorização estendida por 1 ano!"
    redirect_to :back
  end

  def pause
    params_delete = authorized_person_control
    Laboratory.find_by(:id => params_delete[:laboratory_id]).update_attributes(:embedded_update => true)
    AuthorizedPerson.where(:user_id => params_delete[:user_id], :laboratory_id => params_delete[:laboratory_id])[0].update_attributes(:status => "paused")
    flash.notice = "Autorização revogada temporariamente!"
    redirect_to :back
  end

  def unpause
    params_delete = authorized_person_control
    Laboratory.find_by(:id => params_delete[:laboratory_id]).update_attributes(:embedded_update => true)
    AuthorizedPerson.where(:user_id => params_delete[:user_id], :laboratory_id => params_delete[:laboratory_id])[0].update_attributes(:status => "authorized")
    flash.notice = "Autorização revogada temporariamente!"
    redirect_to :back
  end

  def delete
    params_delete = authorized_person_control
    Laboratory.find_by(:id => params_delete[:laboratory_id]).update_attributes(:embedded_update => true)
    AuthorizedPerson.where(:user_id => params_delete[:user_id], :laboratory_id => params_delete[:laboratory_id])[0].delete
    flash.notice = "Autorização revogada permanentemente!"
    redirect_to :back
  end

  private
  def authorized_person_control
    params.require(:authorized_person).permit(:user_id, :laboratory_id, :biometric)
  end

  private
  def authorized_person_params
    params.require(:authorized_person).permit(:user_id, :laboratory_id, :biometric)
  end
end
