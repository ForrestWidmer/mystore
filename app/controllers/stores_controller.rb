class StoresController < ApplicationController
  before_filter :get_store
  skip_around_filter :scope_current_store, only: [:new, :create] #Will remove this later.
  
  def index
    @products = @store.products
    @cart = current_cart
    @stores = Store.all
  end

  def show
    @store = Store.find(params[:id])
  end

  def new
    @store = Store.new
  end

  def edit
    @store = Store.find(params[:id])
  end

  def create
    @store = current_user.stores.build(params[:store])

    if @store.save
      redirect_to root_url(subdomain: @store.subdomain), notice: 'Store was successfully created.'
    else
      render action: "new"
    end
  end

  def update
    @store = Store.find(params[:id])

    if @store.update_attributes(params[:store])
      redirect_to root_url(subdomain: @store.subdomain), notice: 'Store was successfully updated.'
    else
      render action: "edit"
    end
  end

  def destroy
    @store = Store.find(params[:id])
    @store.destroy

    redirect_to root_url(subdomain: false)
  end
end
