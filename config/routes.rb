Rails.application.routes.draw do
  devise_for :users#, skip: [:sessions]
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")

  # devise_scope :user do
  #   get    "login",  to: "home#login", as: :new_user_session
  #   post   "login",  to: "devise/sessions#create", as: :user_session
  #   delete "logout", to: "devise/sessions#destroy", as: :destroy_user_session
  # end

  authenticated :user do
    root "home#index", as: :authenticated_root
  end

  unauthenticated do
    root "home#login", as: :unauthenticated_root
  end

  get 'home', to: 'home#index', as: 'home_index'
  get 'home/batch_import', to: 'home#show_batch_import'
  post 'home/batch_import', to: 'home#batch_import'
  post 'home/:id/upvote', to: 'home#upvote'
  post 'home/:id/downvote', to: 'home#downvote'
end
