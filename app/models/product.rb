class Product < ApplicationRecord
  belongs_to :category
  has_many :line_items, dependent: :destroy
  has_many :wishlist_items, dependent: :destroy
  has_many :order_items, dependent: :destroy

  validates :name, presence: true
  validates :price, presence: true, numericality: { greater_than: 0 }
  validates :stock_count, numericality: { greater_than_or_equal_to: 0 }
  validates :slug, uniqueness: true, allow_blank: true

  scope :featured, -> { where(featured: true) }
  scope :in_stock, -> { where('stock_count > 0') }
  scope :by_category, ->(cat) { joins(:category).where(categories: { slug: cat }) }

  before_validation :generate_slug, if: -> { slug.blank? }

  def in_stock?
    stock_count > 0
  end

  private

  def generate_slug
    self.slug = name.to_s.parameterize
  end
end
