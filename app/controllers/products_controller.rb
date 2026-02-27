class ProductsController < ApplicationController
  def index
    @categories = Category.all
    @products = Product.includes(:category).in_stock

    if params[:category].present?
      @products = @products.by_category(params[:category])
      @active_category = Category.find_by(slug: params[:category])
    end

    if params[:q].present?
      @products = @products.where("name LIKE ?", "%#{params[:q]}%")
    end
  end

  def show
    @product = Product.includes(:category).find_by!(slug: params[:slug])
    @related = Product.where(category: @product.category)
                      .where.not(id: @product.id)
                      .limit(4)
  end
end
