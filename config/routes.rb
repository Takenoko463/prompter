Rails.application.routes.draw do
  root to: "prompts#index"
  resources :prompts,except:[:index] do
    resources :likes ,only:[:create]
    resources :comments ,only:[:index,:new,:create,:edit,:update,:destroy]
  end
  resources :categories, only:[:show] do
    get 'children', on: :member
    resources :prompts , only:[:index]
  end
end
