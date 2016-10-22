Rails.application.routes.draw do

  post 'status/' => 'status#new', :defaults => { :format => :json }
  get '/:initials' => 'laboratory#show', :defaults => { :initials => "LSO" }
  get '/:initials/subjects' => 'laboratory#subjects', :defaults => { :initials => "LSO" }
  get '/:initials/map' => 'laboratory#map', :defaults => { :initials => "LSO" }
  root 'laboratory#show'

end
