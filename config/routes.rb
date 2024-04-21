Rails.application.routes.draw do
  root to: "prompts#index"
  resources :categories, only:[:new]
  resources :prompts do
    resources :comments ,only:[:index,:new,:create,:edit,:update,:destroy]
  end
end
