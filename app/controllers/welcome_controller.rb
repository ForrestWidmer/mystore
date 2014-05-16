class WelcomeController < ApplicationController

  skip_around_filter :scope_current_store

  def home
  end

  def index
    @stores = Store.all
  end

  def about
  end
end
