Rails.application.routes.draw do
  mount RailsIcons::Engine, at: "/rails_icons"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html\
  get "sysinfos/jsons/data/:id", to: "jsons#data"
  #
  root "sysinfos#index"
  resources :sysinfos do
    resources :jsons
  end

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  namespace :api do
    resources :sysinfos, only: [ :index, :show, :create, :update, :destroy ]
  end

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"
end
