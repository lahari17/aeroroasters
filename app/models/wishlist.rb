class Wishlist < ApplicationRecord
  belongs_to :user
  has_many :wishlist_items, dependent: :destroy
  has_many :products, through: :wishlist_items

  def includes_product?(product)
    products.include?(product)
  end

  def add_product(product)
    wishlist_items.find_or_create_by(product: product)
  end

  def remove_product(product)
    wishlist_items.find_by(product: product)&.destroy
  end
end
