ActionController::Routing::Routes.draw do |map|
  map.filter :locale

  map.with_options(:conditions => { :subdomain => true }) do |account|
    account.resources :messages, :only => [:new, :create, :show]
    account.resources :payments, :only => [:new, :create], :has_many => :notifications
    account.resource :user_session, :as => 'session'
    account.resource :account, :only => [:show, :edit, :update, :destroy], :as => ''
  end

  map.with_options(:conditions => { :subdomain => false }) do |site|
    site.resources :accounts, :only => [:new, :create]
    site.root :controller => 'pages' # TODO change this to site.resources :pages, :as => ''
  end
end
