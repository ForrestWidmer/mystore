class LineItemsController < ApplicationController
  
  
  def index
    @line_items = LineItem.all
  end

  def show
    begin
      @line_item = LineItem.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      logger.error "Attempted access to invalid line_item_id"
      flash[:error] = "Not a valid line_item. Please view a valid line_item"
      redirect_to root_url
    end
  end

  def new
    @line_item = LineItem.new
  end

  def edit
    @line_item = LineItem.find(params[:id])
  end

  def create
    @cart = current_cart
    product = Product.find(params[:product_id])
    @line_item = @cart.add_product(product.id)

    respond_to do |format|
      if @line_item.save
        format.js { @current_item = @line_item }
        format.html { redirect_to root_url, notice: 'Line item was successfully created.' }
      else
        format.html { render action: "new" }
      end
    end
  end

  def update
    @line_item = LineItem.find(params[:id])

    if @line_item.update_attributes(params[:line_item])
      redirect_to @line_item, notice: 'Line item was successfully updated.'
    else
      render action: "edit"
    end
  end

  def destroy
    @cart = current_cart
    @line_item = LineItem.find(params[:id])
    @line_item.remove_product(@line_item)

    respond_to do |format|
      format.js
      format.html { redirect_to root_url }
    end
  end
end
