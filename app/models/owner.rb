class Owner < ActiveRecord::Base
  attr_accessible :name, :subdomain
  cattr_accessor :current_id
end
