Rails.application.routes.draw do

  get 'authorized_person/new'

  devise_for :users, controllers: {
    sessions: 'users/sessions',
    :omniauth_callbacks => "users/omniauth_callbacks"
  }

  resources :laboratory do
    post 'reports/' => "report#create"
    get 'reports/' => "report#show"

    get '/subjects' => 'laboratory#subjects', :defaults => { :initials => "LSO" }
    get '/map' => 'laboratory#map', :defaults => { :initials => "LSO" }

    # TODO: need to test this with a embedded system
    post 'computer/:id' => 'status#new_computer', :defaults => { :format => :json }
    post 'status/' => 'status#new_laboratory', :defaults => { :format => :json }
  end

  scope 'dashboard' do
    root :to => 'dashboard#index'
    get 'profile/' => 'dashboard#profile'
    get 'help/' => 'dashboard#help'

    patch 'edit/' => 'dashboard#edit'

    scope ':laboratory_initials' do
      get 'reports/' => 'dashboard#report', as: :dashboard_reports
      patch 'reports/' => 'report#edit', as: :dashboard_reports_edit

      get 'map/' => 'dashboard#map', as: :dashboard_map
      get 'statistics/' => 'dashboard#statistics', as: :dashboard_statistics
      get 'embedded/' => 'dashboard#embedded', as: :dashboard_embedded
    end

  end


  get 'dashboard/access/:initials' => 'dashboard#access'
  post 'dashboard/access/:initials' => 'authorized_person#save'
  delete 'dashboard/access/:initials' => 'authorized_person#delete'
  # orangepi
  post 'dashboard/access/fingerprint/get/all' => 'authorized_person#get'

  post 'dashboard/access/fingerprint/access' => 'biometric#create_access'
  post 'dashboard/access/fingerprint/get' => 'biometric#get_biometric'
  post 'dashboard/access/fingerprint/set' => 'biometric#create'

  get 'about/' => 'application#about'
  root 'laboratory#show'

end
