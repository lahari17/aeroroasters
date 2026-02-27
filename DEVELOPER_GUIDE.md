# AeroRoasters — Developer Guide

> Premium Coffee E-Commerce · Built with Ruby on Rails 8

---

## 🛠 Tech Stack

### Backend
| Technology | Version | Role |
|---|---|---|
| **Ruby** | 3.3.x | Programming language |
| **Ruby on Rails** | 8.1.x | Full-stack web framework (MVC) |
| **Devise** | 5.x | User authentication (sign up, sign in, password reset) |
| **Puma** | 7.x | Web server |

### Frontend
| Technology | Role |
|---|---|
| **ERB** (Embedded Ruby) | HTML templating — views live in `app/views/` |
| **Vanilla CSS** | All styles in `app/assets/stylesheets/application.css` |
| **Hotwire / Turbo** | Built into Rails 8 — enables fast page navigation without full reloads |
| **Google Fonts** | Playfair Display (headings) + Inter (body) loaded via CDN in layout |

### Database
| Technology | Role |
|---|---|
| **SQLite 3** | Local relational database — stored at `storage/development.sqlite3` |
| **Active Record** | Rails ORM — models map to database tables |

---

## 📁 Folder Structure

```
ecomruby/
│
├── app/                        # Main application code
│   ├── assets/
│   │   └── stylesheets/
│   │       └── application.css # ← ALL CSS (design tokens, layout, components)
│   │
│   ├── controllers/            # Handle HTTP requests and responses
│   │   ├── application_controller.rb  # Base controller (Devise params)
│   │   ├── home_controller.rb         # Landing page
│   │   ├── products_controller.rb     # Catalog & product detail
│   │   ├── carts_controller.rb        # View cart
│   │   ├── line_items_controller.rb   # Add/update/remove cart items
│   │   ├── checkouts_controller.rb    # Checkout form
│   │   ├── orders_controller.rb       # Order history & detail
│   │   └── wishlists_controller.rb    # Wishlist management
│   │
│   ├── helpers/
│   │   └── application_helper.rb     # Shared view helpers (format_price, etc.)
│   │
│   ├── models/                 # Database models (Active Record)
│   │   ├── user.rb             # Devise user + owns cart, wishlist, orders
│   │   ├── category.rb         # Product category (auto-generates slug)
│   │   ├── product.rb          # Product with price, stock, image, scopes
│   │   ├── cart.rb             # User's shopping cart (helpers: add_product, total)
│   │   ├── line_item.rb        # An item inside a cart
│   │   ├── wishlist.rb         # User's saved products list
│   │   ├── wishlist_item.rb    # An item inside a wishlist
│   │   ├── order.rb            # A placed order (status: pending → delivered)
│   │   └── order_item.rb       # A product snapshot inside an order
│   │
│   ├── services/               # Business logic (thin controllers pattern)
│   │   └── checkout_service.rb # Converts cart → order in a DB transaction
│   │
│   └── views/                  # HTML templates (ERB)
│       ├── layouts/
│       │   ├── application.html.erb  # Master layout (head, fonts, flash)
│       │   ├── _navbar.html.erb      # Navbar partial
│       │   └── _footer.html.erb      # Footer partial
│       ├── home/
│       │   └── index.html.erb        # Landing page (hero, categories, featured)
│       ├── products/
│       │   ├── index.html.erb        # Catalog with sidebar + search
│       │   ├── show.html.erb         # Product detail page
│       │   └── _product_card.html.erb # Reusable product card partial
│       ├── carts/show.html.erb
│       ├── checkouts/new.html.erb
│       ├── orders/ (index, show)
│       ├── wishlists/show.html.erb
│       └── devise/               # Custom auth pages
│           ├── sessions/new.html.erb       # Sign in
│           ├── registrations/new.html.erb  # Sign up
│           └── shared/_error_messages.html.erb
│
├── config/
│   ├── routes.rb               # ← All URL routes defined here
│   ├── database.yml            # Database connection config
│   ├── environments/
│   │   └── development.rb      # Dev-specific settings
│   └── initializers/
│       └── devise.rb           # Devise configuration
│
├── db/
│   ├── migrate/                # Database migration files (table definitions)
│   ├── schema.rb               # Auto-generated snapshot of current DB schema
│   └── seeds.rb                # Seed data (categories + 12 coffee products)
│
├── public/                     # Static files served directly (404, 500 pages)
├── test/                       # Automated tests
├── Gemfile                     # Ruby gem dependencies
└── DEVELOPER_GUIDE.md          # ← You are here
```

---

## 🗄 Database Schema (Summary)

```
users           → id, email, password, first_name, last_name, phone
categories      → id, name, slug, description
products        → id, name, description, price, stock_count, category_id, slug, featured, image_url
carts           → id, user_id
line_items      → id, cart_id, product_id, quantity, price
wishlists       → id, user_id
wishlist_items  → id, wishlist_id, product_id
orders          → id, user_id, total_price, status, shipping_address, payment_status
order_items     → id, order_id, product_id, quantity, price
```

---

## 🚀 Running the App

```bash
# Start the server
C:\Ruby33-x64\bin\rails server

# Open in browser
http://127.0.0.1:3000

# Re-seed the database
C:\Ruby33-x64\bin\rails db:seed

# Run database migrations after schema changes
C:\Ruby33-x64\bin\rails db:migrate

# Open Rails console (query the DB directly)
C:\Ruby33-x64\bin\rails console
```

---

## 🧩 Key Design Decisions

| Decision | Rationale |
|---|---|
| **Service Objects** (`app/services/`) | Keeps controllers thin — complex logic like checkout is isolated and testable |
| **Partials** (`_product_card`, `_navbar`) | Prevents repeated HTML, makes views modular |
| **Slugs on Category & Product** | Human-readable URLs (`/products?category=whole-bean`) |
| **Auto cart/wishlist on signup** | `User#after_create` callback ensures every user always has a cart and wishlist |
| **Price snapshot on order_items** | Stores price at time of purchase so historical orders are accurate |
