Rails.application.routes.draw do

  get '/user/show' => 'user#show'

  devise_for :users

  get 'dashboard/show'
  get 'about/' => 'application#about'

  post 'status/' => 'status#new_laboratory', :defaults => { :format => :json }
  post '/:initials/status/' => 'status#new_computer', :defaults => { :format => :json }
  get '/laboratory/:initials' => 'laboratory#show', :defaults => { :initials => "LSO" }
  get '/:initials/subjects' => 'laboratory#subjects', :defaults => { :initials => "LSO" }
  get '/:initials/map' => 'laboratory#map', :defaults => { :initials => "LSO" }
  root 'laboratory#show'

end
