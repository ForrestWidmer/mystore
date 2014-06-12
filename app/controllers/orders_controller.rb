class OrdersController < ApplicationController
  before_filter :get_store
  
  
  def index
    @orders = @store.orders
  end

  def show
    begin
      @order = Order.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      logger.error "Attempted access to invalid order_id"
      flash[:error] = "Invalid order. Please view a valid order."
      redirect_to root_url
    end
  end

  def new
    @cart = current_cart
    if @cart.line_items.empty?
      flash[:error] = "Your order was not saved. Make sure you have items in your cart."
      redirect_to root_url
    return
    end
    @order = Order.new
  end

  def edit
    @order = Order.find(params[:id])
  end

  def create
    @order = @store.orders.build(params[:order])
    @order.add_line_items_from_cart(current_cart)

    if @order.save
      Cart.destroy(session[:cart_id])
      session[:cart_id] = nil
      redirect_to root_url, flash: {success: 'Order was successfully created.'}
    else
      render action: "new"
    end
  end

  def update
    @order = Order.find(params[:id])

    if @order.update_attributes(params[:order])
      redirect_to [@store, @order], notice: 'Order was successfully updated.'
    else
      render action: "edit"
    end
  end

  def destroy
    @order = Order.find(params[:id])
    @order.destroy
    redirect_to orders_url
  end
end
