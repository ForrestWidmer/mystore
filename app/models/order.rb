class Order < ActiveRecord::Base
  attr_accessible :address, :email, :name, :pay_type

  default_scope { where(store_id: Store.current_id) }

  has_many :line_items, dependent: :destroy

  PAYMENT_METHODS = ["Credit Card", "Check",  "Cash"]

  validates :address, :email, :name, :pay_type, presence: true
  validates :pay_type, inclusion: { :in => PAYMENT_METHODS }

  def add_line_items_from_cart(cart)
    cart.line_items.each do |item|
      #item.cart_id = nil
      line_items << item      
    end
  end
end
