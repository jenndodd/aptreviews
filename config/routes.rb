Aptreviews::Application.routes.draw do

  resources :apartments, only: [:index, :create, :show, :edit, :update] do 
    resources :reviews
    resources :listings, only: [:new, :create]
    collection do
      get "search"
    end
    member do 
      get "nearby"
    end
  end

  resources :users do
    resources :apartments, only: [:new, :destroy]
  end

  get "/login", to: "session#new"
  post "/session", to: "session#create"
  delete "/session", to: "session#destroy"

  root "welcome#index"

end
