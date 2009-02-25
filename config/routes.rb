ActionController::Routing::Routes.draw do |map|
  map.filter :locale

  # =============================================================================
  # = Subdomains                                                                =
  # =============================================================================
  map.with_options(:conditions => { :subdomain => true }) do |account|
    account.resources :messages, :vcards, :only => [:new, :create, :show]

    account.resources :payments, :only => [:new, :create] do |payment|
      payment.resources :notifications, :only => [:create], :controller => 'payment/notifications'
    end

    account.resource :user_session, :only => [:new, :create, :destroy], :as => 'session'
    account.resource :account, :only => [:show, :edit, :update, :destroy], :as => ''
  end

  # =============================================================================
  # = Top-level Site                                                            =
  # =============================================================================
  map.with_options(:conditions => { :subdomain => false }) do |site|
    site.namespace :admin do |admin|
      admin.resource :administrator_session, :only => [:new, :create, :destroy], :as => 'session'
      admin.root :controller => 'pages'
    end

    site.resources :accounts, :only => [:new, :create]
    site.resources :subscriptions, :only => [:create]
    site.root :controller => 'pages'
  end
end
