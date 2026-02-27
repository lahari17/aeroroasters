class CheckoutsController < ApplicationController
  before_action :authenticate_user!

  def new
    @cart = current_user.cart
    redirect_to cart_path, alert: "Your cart is empty." if @cart.line_items.empty?
  end

  def create
    result = CheckoutService.new(current_user, checkout_params[:shipping_address]).call

    if result == :empty_cart
      redirect_to cart_path, alert: "Your cart is empty."
    elsif result
      # Store card info (demo only) in session to display on success page
      session[:last_order_id]    = result.id
      session[:card_last4]       = checkout_params[:card_last4]
      session[:card_brand]       = checkout_params[:card_brand]
      redirect_to success_checkout_path
    else
      redirect_to new_checkout_path, alert: "Something went wrong. Please try again."
    end
  end

  def success
    order_id = session.delete(:last_order_id)
    redirect_to orders_path and return unless order_id

    @order      = current_user.orders.includes(order_items: :product).find(order_id)
    @card_last4 = session.delete(:card_last4)
    @card_brand = session.delete(:card_brand)
  end

  private

  def checkout_params
    params.require(:checkout).permit(:shipping_address, :card_last4, :card_brand)
  end
end
