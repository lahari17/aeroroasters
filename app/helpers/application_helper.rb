module ApplicationHelper
  def format_price(amount)
    number_to_currency(amount, unit: "$", separator: ".", delimiter: ",")
  end

  def stock_badge(product)
    if product.in_stock?
      content_tag(:span, "In Stock", class: "badge badge--success")
    else
      content_tag(:span, "Out of Stock", class: "badge badge--danger")
    end
  end

  def order_status_class(status)
    {
      "pending"    => "status--pending",
      "processing" => "status--processing",
      "shipped"    => "status--shipped",
      "delivered"  => "status--delivered",
      "cancelled"  => "status--cancelled"
    }[status] || ""
  end

  def category_icon(slug)
    {
      "whole-bean"  => "🫘",
      "espresso"    => "☕",
      "cold-brew"   => "🧊",
      "pods"        => "⚙️",
      "accessories" => "🫖",
      "merchandise" => "👕"
    }[slug.to_s] || "☕"
  end
end
