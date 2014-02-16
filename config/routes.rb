Aptreviews::Application.routes.draw do

  resources :apartments, only: [:index, :show, :edit, :update] do 
    collection do
      get "search"
    end
  end

  resources :users do
    resources :apartments, except: [:index, :show, :edit, :update]
  end

  get "/login", to: "session#new"
  post "/session", to: "session#create"
  delete "/session", to: "session#destroy"

  root "welcome#index"

end
