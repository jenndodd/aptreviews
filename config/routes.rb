Aptreviews::Application.routes.draw do

  resources :apartments do
    resources :listings
    collection do
      get "search"
    end
  end

  root "welcome#index"
end
