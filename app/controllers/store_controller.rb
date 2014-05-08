class StoreController < ApplicationController
  def index
    @products = Product.all
    @counter = session_counter
  end
end
