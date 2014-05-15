class Owner < ActiveRecord::Base
  attr_accessible :name, :subdomain
  cattr_accessor :current_id

  validates :name, :subdomain, uniqueness: true
end
