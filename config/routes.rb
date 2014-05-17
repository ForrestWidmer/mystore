Mystore::Application.routes.draw do

  devise_for :users

  get "/home" => "welcome#home", as: "home"

  get "/about" => "welcome#about", as: "about"

  resources :orders, :line_items, :carts, :stores

  resources :products do
    get :who_bought, on: :member
  end 
  
  match '', to: 'stores#index', constraints: {subdomain: /.+/}
  root to: 'welcome#index'
end