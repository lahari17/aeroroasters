class HomeController < ApplicationController
  def index
    @featured_products = Product.featured.includes(:category).limit(6)
    @categories = Category.all
  end
end
