Rails.application.routes.draw do
  root to: "prompts#index"
  resources :prompts do
    resources :comments ,only:[:index,:new,:create,:edit,:update,:destroy]
  end
  resources :categories do
    get 'children', on: :member
  end
end
