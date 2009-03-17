ActionController::Routing::Routes.draw do |map|
  map.filter :locale

  # =============================================================================
  # = Subdomains                                                                =
  # =============================================================================
  map.with_options(:conditions => { :subdomain => true }) do |account|
    account.resources :text_messages, :vcards, :only => [:new, :create, :show]

    account.resources :payments, :only => [:create] do |payment|
      payment.resources :notifications, :only => [:create], :controller => 'payments/notifications'
    end

    account.resource :user_session, :only => [:new, :create, :destroy], :as => 'session'
    account.resource :account, :only => [:show, :edit, :update, :destroy], :as => ''
  end

  # =============================================================================
  # = Top-level Site                                                            =
  # =============================================================================
  map.with_options(:conditions => { :subdomain => false }) do |site|
    site.namespace :admin do |admin|
      admin.resources :accounts, :only => [:index] do |account|
        account.resources :entries, :only => [:create, :show], :controller => 'accounts/entries'
      end
      admin.resources :subscribers, :only => [:index, :destroy] do |subscriber|
        subscriber.resources :invitations, :only => [:create, :show], :controller => 'subscribers/invitations'
      end
    end

    site.resources :accounts, :only => [:new, :create]
    site.resources :subscribers, :only => [:create]
    site.root :controller => 'pages'
  end
end
