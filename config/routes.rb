Aptreviews::Application.routes.draw do

  resources :apartments do
    collection do
      get "search"
    end
  end

  root "welcome#index"
end
