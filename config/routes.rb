Mystore::Application.routes.draw do

  resources :orders


  resources :line_items


  resources :carts


  resources :products do
    get :who_bought, on: :member
  end 
  
  root to: 'store#index', as: 'store'
end