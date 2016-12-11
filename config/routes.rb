Rails.application.routes.draw do

  get 'authorized_person/new'

  devise_for :users, controllers: {
    sessions: 'users/sessions',
    :omniauth_callbacks => "users/omniauth_callbacks"
  }

  post 'report/' => "report#create"
  get 'report/show' => "report#show"

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

  post 'status/' => 'status#new_laboratory', :defaults => { :format => :json }
  post '/:initials/status/' => 'status#new_computer', :defaults => { :format => :json }
  get '/laboratory/:initials' => 'laboratory#show', :defaults => { :initials => "LSO" }
  get '/:initials/subjects' => 'laboratory#subjects', :defaults => { :initials => "LSO" }
  get '/:initials/map' => 'laboratory#map', :defaults => { :initials => "LSO" }
  get '/:initials' => 'laboratory#show'
  root 'laboratory#show'

end
