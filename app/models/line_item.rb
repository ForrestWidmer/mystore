class LineItem < ActiveRecord::Base
  attr_accessible :cart_id, :product_id, :product, :quantity

  belongs_to :order
  belongs_to :product 
  belongs_to :cart

  def price
    product.price * quantity
  end
  #if there is at least two products, decrement quantity by 1
  #else, meaning there is only 1 product, destroy it.
  def remove_product(line_item)
    if line_item.quantity >= 2
      line_item.update_attributes(quantity: line_item.quantity - 1)
    else
      line_item.destroy
    end
  end
end
