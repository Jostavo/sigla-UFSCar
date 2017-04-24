class Users::RegistrationsController < Devise::RegistrationsController
before_action :configure_sign_up_params, only: [:create]
before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  # def new
  #   super
  # end

  # POST /resource
  def create
    super
  end

  # GET /resource/edit
  def edit
    @students = User.where.not(:id => User.joins("INNER JOIN users_advisors ON users.id = users_advisors.student_id").select("id").map(&:id)).where(:type_user => "graduation"||"post-graduate")
    super
  end

  # PUT /resource
  def update
    @students = User.where.not(:id => User.joins("INNER JOIN users_advisors ON users.id = users_advisors.student_id").select("id").map(&:id)).where(:type_user => "graduation"||"post-graduate")
    self.resource = resource_class.to_adapter.get!(send(:"current_#{resource_name}").to_key)
    prev_unconfirmed_email = resource.unconfirmed_email if resource.respond_to?(:unconfirmed_email)

    resource_updated = update_resource(resource, account_update_params)
    yield resource if block_given?
    if resource_updated

      if resource.type_user == "professor"
        list_students = params[:user][:users_advisor].map{|x| x[1]}
        list_students_temp = UsersAdvisor.where(:professor_id => resource.id).map(&:student_id)

        if list_students.empty?
          UsersAdvisor.where(:professor_id => resource.id).each do |u|
            u.delete
          end
        else
          list_to_delete = list_students_temp - list_students
          list_to_add = list_students - list_students_temp

          UsersAdvisor.where(:professor_id => resource.id, :student_id => list_to_delete).delete_all
          list_to_add.each do |u|
            UsersAdvisor.create(:professor_id => resource.id, :student_id => u)
          end
        end
      end

      if is_flashing_format?
        flash_key = update_needs_confirmation?(resource, prev_unconfirmed_email) ?
          :update_needs_confirmation : :updated
        set_flash_message :notice, flash_key
      end
      bypass_sign_in resource, scope: resource_name
      respond_with resource, location: after_update_path_for(resource)
    else
      clean_up_passwords resource
      set_minimum_password_length
      respond_with resource
    end
  end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  protected

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:type_user])
  end

  # If you have extra params to permit, append them to the sanitizer.
  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: [:type_user, :users_advisor, :name])
  end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
