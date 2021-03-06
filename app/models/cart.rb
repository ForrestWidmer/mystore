class Cart < ActiveRecord::Base
  # attr_accessible :title, :body
  has_many :line_items, dependent: :destroy

  default_scope { where(store_id: Store.current_id) }

  def add_product(product_id)
    current_item = line_items.where(:product_id => product_id).first
    if current_item
      current_item.quantity += 1
    else
      current_item = line_items.build(:product_id => product_id)
    end
    current_item
  end

  def total_items
    line_items.sum(:quantity)
  end

  def total_price
    line_items.to_a.sum {|item| item.price}
  end
end
