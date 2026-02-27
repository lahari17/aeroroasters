# ☕ AeroRoasters

> A full-stack e-commerce web application for a premium coffee brand, built as a portfolio project using **Ruby on Rails 8**.

---

## 📌 Project Summary

AeroRoasters is a fully functional online coffee shop that demonstrates production-grade Rails architecture. It features user authentication, a product catalog with categories, persistent shopping cart, wishlist, a transactional checkout system, order history, and a realistic payment card UX — all without any CSS frameworks.

---

## 🛠 Tech Stack

| Layer | Technology |
|---|---|
| **Language** | Ruby 3.3 |
| **Framework** | Ruby on Rails 8.1 |
| **Database** | SQLite 3 via Active Record ORM |
| **Authentication** | Devise 5 |
| **Frontend Rendering** | ERB (Embedded Ruby) templates |
| **Styling** | Vanilla CSS (custom design system, 1300+ lines) |
| **JS** | Vanilla JavaScript (card UX, live previews) |
| **Navigation** | Hotwire / Turbo (built into Rails 8) |
| **Web Server** | Puma 7 |
| **Fonts** | Google Fonts — Playfair Display + Inter |

---

## ✨ Features

- **User Accounts** — Sign up with first name, last name, email, phone. Secure login/logout via Devise. Cart and wishlist are auto-created on registration.
- **Product Catalog** — 12 products across 6 categories (Whole Bean, Espresso, Cold Brew, Pods, Accessories, Merchandise). Category sidebar and keyword search on the catalog page.
- **Product Detail Pages** — Description, price, stock status badge, add-to-cart form, and wishlist button.
- **Shopping Cart** — Persistent per-user cart. Inline quantity update, remove item, and running subtotal.
- **Wishlist** — Save products for later. Move to cart or remove directly from the wishlist page.
- **Checkout & Orders** — Shipping address form, transactional order placement via `CheckoutService`, order history with status tracking (pending → processing → shipped → delivered).
- **Payment Card UX** — Live 3D card preview that updates in real-time as you type. Card flips to show CVV field on the back. Brand auto-detection (Visa, Mastercard, Amex). Gradient pay button with loading spinner on submit.
- **Order Success Page** — Animated SVG checkmark confirmation, personalized message, order summary with card last 4 digits.
- **Responsive Design** — Mobile-friendly layout with breakpoints at 900px and 600px.

---

## 🗄 Database Schema

```
users          → id, email, encrypted_password, first_name, last_name, phone
categories     → id, name, slug, description
products       → id, name, description, price, stock_count, category_id, slug, featured, image_url
carts          → id, user_id
line_items     → id, cart_id, product_id, quantity, price
wishlists      → id, user_id
wishlist_items → id, wishlist_id, product_id
orders         → id, user_id, total_price, status, shipping_address, payment_status
order_items    → id, order_id, product_id, quantity, price
```

---

## 🏗 Architecture Highlights

| Pattern | Implementation |
|---|---|
| **Service Objects** | `CheckoutService` wraps cart → order transaction, keeping the controller thin |
| **Thin Controllers** | Controllers only parse params and delegate to services or models |
| **Model Helpers** | `Cart#add_product`, `Cart#total_price`, `Wishlist#add_product` encapsulate domain logic |
| **Idempotent Seeds** | `find_or_create_by!` ensures `db:seed` is safe to re-run |
| **Price Snapshots** | `order_items.price` stores price at purchase time — historical orders stay accurate |
| **Auto-slug** | `before_validation` callback on Category and Product auto-generates URL-friendly slugs |
| **Callbacks** | `User#after_create` auto-creates cart and wishlist for every new user |

---

## 📁 Key Directories

```
app/controllers/   # Thin controllers — one per resource
app/models/        # Active Record models with associations and validations
app/services/      # CheckoutService — business logic layer
app/views/         # ERB templates with shared partials (_navbar, _footer, _product_card)
app/helpers/       # ApplicationHelper — format_price, stock_badge, category_icon
app/assets/stylesheets/application.css  # Full CSS design system
config/routes.rb   # RESTful routes for all features
db/migrate/        # 10 migration files
db/seeds.rb        # Seed data — 2 demo users, 6 categories, 12 products
```

---

## 🚀 Getting Started

```bash
# Run the server
C:\Ruby33-x64\bin\rails server

# Open in browser
http://127.0.0.1:3000
```

**Demo credentials:**

| Email | Password |
|---|---|
| `demo@aerorasters.com` | `password123` |
| `jordan@aerorasters.com` | `password123` |

```bash
# Reset and re-seed the database
C:\Ruby33-x64\bin\rails db:seed

# Run migrations after schema changes
C:\Ruby33-x64\bin\rails db:migrate

# Open the Rails console
C:\Ruby33-x64\bin\rails console
```

---

## 📄 Resume Summary

> Built **AeroRoasters**, a full-stack Ruby on Rails 8 e-commerce application featuring Devise authentication, a 9-table relational SQLite schema, persistent shopping cart, transactional checkout via Service Objects, order management, and a polished payment card UX with live 3D CSS animations — all styled with a custom vanilla CSS design system and zero frontend frameworks.

**Keywords:** `Ruby on Rails 8` · `Ruby 3.3` · `SQLite / Active Record` · `Devise` · `Hotwire / Turbo` · `ERB` · `Vanilla CSS & JS` · `REST` · `MVC` · `Service Objects`

---

*See [`DEVELOPER_GUIDE.md`](DEVELOPER_GUIDE.md) for the full folder structure and technical documentation.*
