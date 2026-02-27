class Cart < ApplicationRecord
  belongs_to :user
  has_many :line_items, dependent: :destroy
  has_many :products, through: :line_items

  def total_price
    line_items.sum { |item| item.price * item.quantity }
  end

  def item_count
    line_items.sum(:quantity)
  end

  def add_product(product, quantity = 1)
    existing = line_items.find_by(product: product)
    if existing
      existing.increment!(:quantity, quantity)
    else
      line_items.create!(product: product, quantity: quantity, price: product.price)
    end
  end
end
