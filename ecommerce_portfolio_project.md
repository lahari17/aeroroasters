# E-Commerce Portfolio Project Architecture

This document describes the structure and features for a robust, modular E-commerce application built with Ruby on Rails.

## 1. Core Features

### 1.1 User Accounts
- **Authentication**: Secure login/registration, password recovery (typically via `Devise`).
- **Profile Management**: Profile details, address management, past orders history.

### 1.2 Catalog Management
- **Categories**: Hierarchical categorization of products (e.g., Electronics, Clothing).
- **Products**: Detailed listings including title, description, price, inventory count, and associated images.
- **Search & Filter**: Find products efficiently based on names or categories.

### 1.3 Shopping Experience
- **Shopping Cart**: Session-based or persistent storage for products users intend to buy.
- **Line Items**: Individual cart entries linking a product with its selected quantity.
- **Shopping List / Wishlist**: A place for users to save products for future consideration.

### 1.4 Checkout & Orders
- **Checkout Flow**: Step-by-step collection of shipping, billing, and payment mechanisms.
- **Order Tracking**: Stored records of finalized transactions.

## 2. Directory Structure & Modularity
To avoid heavy, bloated code (e.g., "Fat Models, Fat Controllers"), this project adheres to strict modularity:

* **`/app/models`** - Strictly handles database relationships, validations, and simple querying.
* **`/app/services`** (New Directory) - Houses business logic and complex transactions (e.g., `CheckoutService`, `CartManager`) keeping controllers and models lightweight.
* **`/app/controllers`** - Thin controllers responsible only for parsing HTTP requests, triggering appropriate services, and returning views or JSON.
* **`/app/views`** - Modularized using partials (`_header.html.erb`, `_product_card.html.erb`) to prevent large, monolithic HTML files.
* **`/app/helpers`** - Reusable view logic formatting helpers (e.g., price formatters).

## 3. Recommended Rails Structure

```
app/
  controllers/
    storefront/
      products_controller.rb
      categories_controller.rb
    checkout/
      carts_controller.rb
      orders_controller.rb
    users/
      sessions_controller.rb
  models/
    user.rb
    product.rb
    category.rb
    cart.rb
    line_item.rb
    order.rb
    wishlist.rb
  services/
    checkout_service.rb
    payment_processor.rb
  views/
    layouts/
      application.html.erb
    storefront/
      products/
        index.html.erb
        show.html.erb
        _product.html.erb    # Partial 
```

## 4. UI/UX Focus
- Modern, clean aesthetic using standardized CSS logic to make the portfolio stand out.
- Responsive design enabling use on desktop and mobile.
- Clean transitions and micro-interactions for adding items to the cart or filtering products.
