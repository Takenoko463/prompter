Rails.application.routes.draw do
  devise_for :users
  root to: "prompts#index"
  resources :prompts do
    resources :comments ,only:[:index,:new,:create,:edit,:update,:destroy]
  end
end
