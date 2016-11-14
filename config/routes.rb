Rails.application.routes.draw do

  devise_for :users, controllers: {
    sessions: 'users/sessions',
    :omniauth_callbacks => "users/omniauth_callbacks"
  }

  get 'dashboard/' => 'dashboard#show'
  get 'dashboard/profile' => 'dashboard#profile'
  patch 'dashboard/edit' => 'dashboard#edit'

  get 'about/' => 'application#about'

  post 'status/' => 'status#new_laboratory', :defaults => { :format => :json }
  post '/:initials/status/' => 'status#new_computer', :defaults => { :format => :json }
  get '/laboratory/:initials' => 'laboratory#show', :defaults => { :initials => "LSO" }
  get '/:initials/subjects' => 'laboratory#subjects', :defaults => { :initials => "LSO" }
  get '/:initials/map' => 'laboratory#map', :defaults => { :initials => "LSO" }
  root 'laboratory#show'

end
