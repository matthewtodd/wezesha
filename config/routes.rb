ActionController::Routing::Routes.draw do |map|
  map.filter :locale

  map.with_options(:conditions => { :subdomain => true }) do |account|
    account.resource :user_session, :as => 'session'
    account.resource :account, :only => [:show, :edit, :update, :destroy], :as => ''
  end

  map.with_options(:conditions => { :subdomain => false }) do |site|
    site.resources :accounts, :only => [:new, :create]
    site.root :controller => 'pages'
  end
end
