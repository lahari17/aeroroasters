# AeroRoasters – Seed data

# ─── Demo Users ───────────────────────────────────────────────
demo_users = [
  {
    first_name: 'Alex', last_name: 'Roaster',
    email: 'demo@aerorasters.com', password: 'password123',
    phone: '555-010-1234'
  },
  {
    first_name: 'Jordan', last_name: 'Brew',
    email: 'jordan@aerorasters.com', password: 'password123',
    phone: '555-020-5678'
  }
]

demo_users.each do |attrs|
  user = User.find_or_initialize_by(email: attrs[:email])
  unless user.persisted?
    user.assign_attributes(attrs)
    user.save!
  end
end

puts "Demo users ready:"
puts "  📧 demo@aerorasters.com   / password: password123"
puts "  📧 jordan@aerorasters.com / password: password123"

# ─── Categories ──────────────────────────────────────────────
categories = {
  'Whole Bean'  => { slug: 'whole-bean',  description: 'Premium whole beans sourced from the world\'s finest farms.' },
  'Espresso'    => { slug: 'espresso',    description: 'Bold, concentrated blends crafted for espresso brewing.' },
  'Cold Brew'   => { slug: 'cold-brew',   description: 'Smooth, slow-steeped cold brew blends for warm days.' },
  'Pods'        => { slug: 'pods',        description: 'Compatible single-serve pods for quick, quality brews.' },
  'Accessories' => { slug: 'accessories', description: 'Premium brewing gear for the coffee enthusiast.' },
  'Merchandise' => { slug: 'merchandise', description: 'Show your love for great coffee.' }
}

category_records = {}
categories.each do |name, attrs|
  category_records[name] = Category.find_or_create_by!(name: name) do |c|
    c.slug        = attrs[:slug]
    c.description = attrs[:description]
  end
end

puts "Created #{category_records.count} categories"

# ─── Products ──────────────────────────────────────────────
products = [
  # Whole Bean
  {
    category: 'Whole Bean', name: 'Ethiopian Yirgacheffe', price: 24.99,
    stock_count: 50, featured: true,
    image_url: 'https://images.unsplash.com/photo-1559056199-641a0ac8b55e?w=600&q=80',
    description: 'Bright and floral with notes of bergamot, jasmine, and stone fruit. Single-origin from Yirgacheffe, Ethiopia.'
  },
  {
    category: 'Whole Bean', name: 'Colombian Supremo', price: 21.99,
    stock_count: 60, featured: true,
    image_url: 'https://images.unsplash.com/photo-1509042239860-f550ce710b93?w=600&q=80',
    description: 'A classic medium roast with balanced caramel sweetness, mild citrus, and a velvety finish.'
  },
  {
    category: 'Whole Bean', name: 'Guatemalan Antigua', price: 22.99,
    stock_count: 45, featured: false,
    image_url: 'https://images.unsplash.com/photo-1495474472287-4d71bcdd2085?w=600&q=80',
    description: 'Full-bodied with rich chocolate and brown sugar tones. Grown at high altitude for exceptional complexity.'
  },
  {
    category: 'Whole Bean', name: 'Kenyan AA Single Origin', price: 26.99,
    stock_count: 30, featured: true,
    image_url: 'https://images.unsplash.com/photo-1447933601403-0c6688de566e?w=600&q=80',
    description: 'Bold wine-like acidity with blackcurrant and tomato notes. A complex and vibrant cup of Kenyan excellence.'
  },
  # Espresso
  {
    category: 'Espresso', name: 'Midnight Espresso Blend', price: 23.99,
    stock_count: 80, featured: true,
    image_url: 'https://images.unsplash.com/photo-1514432324607-a09d9b4aefdd?w=600&q=80',
    description: 'Dark, intense, and perfectly balanced. A blend of Brazilian and Ethiopian beans engineered for the perfect shot.'
  },
  {
    category: 'Espresso', name: 'Golden Crema Espresso', price: 19.99,
    stock_count: 70, featured: false,
    image_url: 'https://images.unsplash.com/photo-1485808191679-5f86510bd9d4?w=600&q=80',
    description: 'A smooth, crowd-pleasing espresso with notes of hazelnut, caramel, and dark chocolate on the finish.'
  },
  # Cold Brew
  {
    category: 'Cold Brew', name: 'Signature Cold Brew Blend', price: 17.99,
    stock_count: 40, featured: true,
    image_url: 'https://images.unsplash.com/photo-1461023058943-07fcbe16d735?w=600&q=80',
    description: 'Our specially crafted blend for slow cold extraction. Produces a smooth, chocolatey, low-acid concentrate.'
  },
  {
    category: 'Cold Brew', name: 'Caribbean Vanilla Cold Brew', price: 18.99,
    stock_count: 35, featured: false,
    image_url: 'https://images.unsplash.com/photo-1541167760496-1628856ab772?w=600&q=80',
    description: 'A tropical twist on cold brew. Infused with real Madagascar vanilla for a cafe-style treat at home.'
  },
  # Pods
  {
    category: 'Pods', name: 'Morning Ritual Pods (10 pack)', price: 14.99,
    stock_count: 100, featured: false,
    image_url: 'https://images.unsplash.com/photo-1509785307050-d4066910ec1e?w=600&q=80',
    description: 'Compatible with most capsule machines. Rich, full-bodied coffee without the compromise.'
  },
  # Accessories
  {
    category: 'Accessories', name: 'AeroRoasters Gooseneck Kettle', price: 54.99,
    stock_count: 20, featured: false,
    image_url: 'https://images.unsplash.com/photo-1544787219-7f47ccb76574?w=600&q=80',
    description: 'Precision pour control for pour-over excellence. Matte black design with temperature-hold feature.'
  },
  {
    category: 'Accessories', name: 'Burr Grinder Pro', price: 89.99,
    stock_count: 15, featured: true,
    image_url: 'https://images.unsplash.com/photo-1571066811602-716837d681de?w=600&q=80',
    description: 'Conical burr grinder with 15 grind settings — from fine espresso to coarse French press. Freshness unlocked.'
  },
  # Merchandise
  {
    category: 'Merchandise', name: 'AeroRoasters Tote Bag', price: 18.00,
    stock_count: 50, featured: false,
    image_url: 'https://images.unsplash.com/photo-1553062407-98eeb64c6a62?w=600&q=80',
    description: 'Durable canvas tote with the AeroRoasters emblem. Perfect for your local market or weekend grind.'
  }
]

products.each do |attrs|
  cat = category_records[attrs.delete(:category)]
  Product.find_or_create_by!(name: attrs[:name]) do |p|
    attrs.each { |k, v| p.send("#{k}=", v) }
    p.category = cat
  end
end

puts "Created #{Product.count} products across #{Category.count} categories"
puts "✅ AeroRoasters seed data loaded!"
