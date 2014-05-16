class WelcomeController < ApplicationController

  skip_around_filter :scope_current_owner

  def home
  end

  def index
    @owners = Owner.all
  end

  def about
  end
end
