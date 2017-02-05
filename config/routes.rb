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

  get 'dashboard/' => 'dashboard#show'
  get 'dashboard/profile' => 'dashboard#profile'
  get 'dashboard/help' => 'dashboard#help'
  patch 'dashboard/edit' => 'dashboard#edit'

  get 'dashboard/report/:initials/' => 'dashboard#report'
  post 'dashboard/report/:initials/' => 'report#edit'

  get 'dashboard/map/:initials' => 'dashboard#map'
  get 'dashboard/statistics/:initials' => 'dashboard#statistics'
  get 'dashboard/embedded/:initials' => 'dashboard#embedded'
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
