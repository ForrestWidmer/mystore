class Product < ActiveRecord::Base
  attr_accessible :description, :image_url, :price, :title

  default_scope { where(owner_id: Owner.current_id) }

  scope :order, order('title')

  has_many :line_items
  has_many :orders, through: :line_items

  before_destroy :ensure_not_referenced_by_line_item

  
  validates :description, :image_url, :title, presence: true
  validates :price, :numericality => {:greater_than_or_equal_to => 0.01}
  validates :title, uniqueness: { scope: :owner_id }
  validates :image_url, format: {
    with: %r{\.(gif|jpg|png|jpeg)$}i,
    message: "Must be a URL for a GIF, JPG, JPEG, or PNG." 
  }

  def ensure_not_referenced_by_line_item
    if line_items.count.zero?
      return true
    else
      errors.add(:base, "Line Items present")
      return false
    end
  end
end
