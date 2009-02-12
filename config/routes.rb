ActionController::Routing::Routes.draw do |map|
  map.filter :locale

  map.resources :accounts
  map.resource :session
end
