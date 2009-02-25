ActionController::Routing::Routes.draw do |map|
  map.filter :locale

  map.with_options(:conditions => { :subdomain => true }) do |account|
    account.resources :messages, :vcards, :only => [:new, :create, :show]

    account.resources :payments, :only => [:new, :create] do |payment|
      payment.resources :notifications, :only => [:create], :controller => 'payment/notifications'
    end

    account.resource :user_session, :as => 'session'
    account.resource :account, :only => [:show, :edit, :update, :destroy], :as => ''
  end

  map.with_options(:conditions => { :subdomain => false }) do |site|
    site.resources :accounts, :only => [:new, :create]
    site.resources :subscriptions, :only => [:create]
    site.root :controller => 'pages'
  end
end
