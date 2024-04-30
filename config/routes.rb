Rails.application.routes.draw do
  root to: "ips#create"
  resources :prompts do
    resource :likes ,only:[:create,:destroy]
    resources :comments ,only:[:index,:new,:create,:edit,:update,:destroy]
  end
  resources :categories, only:[:show] do
    get 'children', on: :member
    resources :prompts , only:[:index]
  end
  resources :ips,only:[:create]
end
