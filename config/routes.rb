Mystore::Application.routes.draw do

  resources :products
  root to: 'store#index', as: 'store'
end