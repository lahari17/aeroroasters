class LineItemsController < ApplicationController
  before_action :authenticate_user!

  def create
    product = Product.find(params[:product_id])
    quantity = (params[:quantity] || 1).to_i
    current_user.cart.add_product(product, quantity)
    redirect_to cart_path, notice: "#{product.name} added to your cart!"
  rescue ActiveRecord::RecordNotFound
    redirect_to products_path, alert: "Product not found."
  end

  def update
    item = current_user.cart.line_items.find(params[:id])
    if params[:quantity].to_i > 0
      item.update!(quantity: params[:quantity].to_i)
    else
      item.destroy
    end
    redirect_to cart_path
  end

  def destroy
    item = current_user.cart.line_items.find(params[:id])
    item.destroy
    redirect_to cart_path, notice: "Item removed from cart."
  end
end
