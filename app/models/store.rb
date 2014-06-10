class Store < ActiveRecord::Base
  attr_accessible :name, :subdomain
  cattr_accessor :current_id # cattr_accessor creates a class level accessor

  has_many :products, dependent: :destroy
  

  belongs_to :user

  validates :name, :subdomain, uniqueness: true
end
