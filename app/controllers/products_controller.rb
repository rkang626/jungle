class ProductsController < ApplicationController

  def index
    @products = Product.all.order(created_at: :desc)
  end

  def show
    @product = Product.find params[:id]
    @reviews = @product.reviews.select('*').joins(:user).order(created_at: :desc)
    @current_user = current_user
  end

end
