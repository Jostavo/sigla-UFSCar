Rails.application.routes.draw do

  post 'status/' => 'status#new', :defaults => { :format => :json }
  get '/:initials' => 'laboratory#show', :defaults => { :initials => "LSO" }
<<<<<<< HEAD
=======
  get '/:initials/subjects' => 'laboratory#subjects', :defaults => { :initials => "LSO" }
  get '/:initials/map' => 'laboratory#map', :defaults => { :initials => "LSO" }
>>>>>>> 73fec0d... Changed frontpage, create a new route for iframe
  root 'laboratory#show'

end
