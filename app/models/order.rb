class Order < ApplicationRecord
  belongs_to :user
  has_many :order_items, dependent: :destroy
  has_many :products, through: :order_items

  STATUSES = %w[pending processing shipped delivered cancelled].freeze

  validates :status, inclusion: { in: STATUSES }
  validates :total_price, numericality: { greater_than_or_equal_to: 0 }

  scope :recent, -> { order(created_at: :desc) }

  def pending?    = status == "pending"
  def processing? = status == "processing"
  def shipped?    = status == "shipped"
  def delivered?  = status == "delivered"
  def cancelled?  = status == "cancelled"
end
