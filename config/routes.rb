Rails.application.routes.draw do
  root to: "prompts#index"
  get "prompts/index"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
