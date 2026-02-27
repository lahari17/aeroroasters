class WishlistsController < ApplicationController
  before_action :authenticate_user!

  def show
    @wishlist = current_user.wishlist
  end

  def add
    product = Product.find(params[:product_id])
    current_user.wishlist.add_product(product)
    redirect_back fallback_location: product_path(product.slug), notice: "Added to wishlist!"
  end

  def remove
    product = Product.find(params[:product_id])
    current_user.wishlist.remove_product(product)
    redirect_back fallback_location: wishlist_path, notice: "Removed from wishlist."
  end
end
