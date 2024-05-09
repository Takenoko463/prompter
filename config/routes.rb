Rails.application.routes.draw do
  root to: "ips#create"
  resources :prompts do
    get 'search', on: :collection
    resource :likes ,only:[:create,:destroy]
    resources :comments ,only:[:index,:new,:create,:update]
  end
  resources :comments,only:[:edit,:show,:destroy]
  resources :categories, only: :index
  resources :categories, only:[:show] do
    get 'children', on: :member
  end
  resources :ips,only:[:create]
end
