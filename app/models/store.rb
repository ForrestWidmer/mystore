class Store < ActiveRecord::Base
  attr_accessible :name, :subdomain
  cattr_accessor :current_id

  belongs_to :user

  validates :name, :subdomain, uniqueness: true
end
