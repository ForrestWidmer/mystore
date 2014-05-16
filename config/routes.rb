Mystore::Application.routes.draw do

  get "welcome/home"

  get "welcome/index"

  get "welcome/about"

  resources :orders


  resources :line_items

  resources :owners


  resources :carts


  resources :products do
    get :who_bought, on: :member
  end 
  
  match '', to: 'store#index', constraints: {subdomain: /.+/}
  root to: 'welcome#index'
end