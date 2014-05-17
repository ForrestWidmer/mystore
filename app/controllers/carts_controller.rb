class CartsController < ApplicationController
  
  
  def index
    @carts = Cart.all
  end

  def show
    begin
      @cart = Cart.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      logger.error "Attempted access to invalid cart id."
      flash[:error] = "That cart does not exist."
      redirect_to root_url
    end
  end
  
  def new
    @cart = Cart.new
  end
  
  def edit
    @cart = Cart.find(params[:id])
  end

  def create
    @cart = Cart.new(params[:cart])

    if @cart.save
      redirect_to @cart, notice: 'Cart was successfully created.'
    else
      render action: "new"
    end
  end

  def update
    @cart = Cart.find(params[:id])

    if @cart.update_attributes(params[:cart])
      redirect_to @cart, notice: 'Cart was successfully updated.'
    else
      render action: "edit"
    end
  end

  def destroy
    @cart = current_cart
    @cart.destroy
    session[:cart_id] = nil

    respond_to do |format|
      format.js
      format.html { redirect_to root_url }
      format.json { head :no_content }
    end
  end
end
