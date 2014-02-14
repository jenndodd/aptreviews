Aptreviews::Application.routes.draw do
  resources :apartments

  root "welcome#index"
end
