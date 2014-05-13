class StoreController < ApplicationController
  def index
    @products = Product.all
    @counter = session_counter
    @cart = current_cart
  end
end
