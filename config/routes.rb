Rails.application.routes.draw do
  root to: "prompts#index"
  resources :prompts,only: [:index,:new,:create]
end
