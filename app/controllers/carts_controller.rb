class CartsController < ApplicationController
  def show
    # binding.pry
    @current_cart = current_user.current_cart
  end

  def checkout
    # binding.pry
    redirect_to cart_path(current_user.current_cart)
  end
end
