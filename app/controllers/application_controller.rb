class ApplicationController < ActionController::Base
  protect_from_forgery

  around_filter :scope_current_owner

private

  def current_owner
    Owner.find_by_subdomain! request.subdomain
  end
  helper_method :current_owner

  def current_cart
    Cart.find(session[:cart_id])
  rescue ActiveRecord::RecordNotFound
    cart = Cart.create
    session[:cart_id] = cart.id 
    cart
  end

  def session_counter
    if session[:counter].nil?
      session[:counter] = 0
    end
    session[:counter] += 1
  end

  def scope_current_owner
    Owner.current_id = current_owner.id
    yield
  ensure
    Owner.current_id = nil
  end
end
