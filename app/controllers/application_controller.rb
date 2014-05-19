class ApplicationController < ActionController::Base
  protect_from_forgery

  around_filter :scope_current_store

protected

  def after_sign_in_path_for(resource)
    home_path
  end

private

  def current_store
    Store.find_by_subdomain! request.subdomain
  end
  helper_method :current_store

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

  def scope_current_store
    Store.current_id = current_store.id
    yield
  ensure
    Store.current_id = nil
  end
end
