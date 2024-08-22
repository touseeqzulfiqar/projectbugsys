Rails.application.routes.draw do  
# get 'suggestion', to: 'projects#suggestion'
# post 'suggestion', to: 'projects#suggestion'
  post "search/search", default: {format: :turbo_stream}

  # resources :bugs
  root "projects#index"
  resources :projects do 
    collection do
    patch :bulk_update
    post :search
  end
    resources :bugs do
      # member do
      #   put :update_status
      # end
      post "status_update", on: :member
    end
    
  end
  get "all_bugs", to: "bugs#all_bugs"
  
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
  post "suggestion", to: "projects#suggestion"
  # Defines the root path route ("/")
  # root "posts#index"
end
