ActionController::Routing::Routes.draw do |map|
  map.resources :accounts

  map.resource :session
end
