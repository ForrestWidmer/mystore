class ProductsController < ApplicationController
  before_filter :get_store
  before_filter :authorize, only: :new #Will add better authorization later.
 
  def who_bought
    @product = Product.find(params[:id])
    respond_to do |format|
      format.atom
      format.xml { render :xml => @product }
    end
  end

  def index
    @products = current_store.products
  end
 
  def show
    begin
      @product = Product.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      flash[:error] = "Not a valid product."
      redirect_to store_url
    end
  end

  def new
    @product = Product.new
  end
 
  def edit
    @product = Product.find(params[:id])
  end
 
  def create
    @product = @store.products.build(params[:product])

    if @product.save
      redirect_to root_path, notice: 'Product was successfully created.'
    else
      render action: "new"
    end
  end

  def update
    @product = Product.find(params[:id])

    if @product.update_attributes(params[:product])
      redirect_to [@store, @product], notice: 'Product was successfully updated.'
    else
      render action: "edit"
    end
  end

  def destroy
    @product = Product.find(params[:id])
    @product.destroy

    redirect_to :back
  end

  def get_store
    @store = current_store
  end
end
