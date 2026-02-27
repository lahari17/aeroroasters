class CheckoutService
  def initialize(user, shipping_address)
    @user = user
    @cart = user.cart
    @shipping_address = shipping_address
  end

  def call
    return :empty_cart if @cart.line_items.empty?

    ActiveRecord::Base.transaction do
      order = create_order
      transfer_items(order)
      @cart.line_items.destroy_all
      order
    end
  rescue ActiveRecord::RecordInvalid => e
    Rails.logger.error "Checkout failed: #{e.message}"
    nil
  end

  private

  def create_order
    @user.orders.create!(
      total_price: @cart.total_price,
      shipping_address: @shipping_address,
      status: "pending",
      payment_status: "unpaid"
    )
  end

  def transfer_items(order)
    @cart.line_items.each do |item|
      order.order_items.create!(
        product: item.product,
        quantity: item.quantity,
        price: item.price
      )
    end
  end
end
