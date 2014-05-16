Mystore::Application.routes.draw do

  get "welcome/home"

  get "welcome/index"

  get "welcome/about"

  resources :orders

  resources :line_items

  resources :carts

  resources :stores

  resources :products do
    get :who_bought, on: :member
  end 
  
  match '', to: 'stores#index', constraints: {subdomain: /.+/}
  root to: 'welcome#index'
end