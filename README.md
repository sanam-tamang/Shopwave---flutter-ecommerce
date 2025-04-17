# ShopWave - E-Commerce Platform

ShopWave is an e-commerce mobile application built with Flutter and Supabase. It offers a shopping experience with a clean UI and essential e-commerce features. The platform supports multiple user roles (Customer, Vendor, Admin) with role-specific functionalities.

## 📱 Screenshots

### Customer Experience

<div style="display: flex; flex-wrap: wrap; justify-content: center;">
  <img src="screenshots/home.png" alt="Home Screen" width="200" style="margin: 10px;"/>
  <img src="screenshots/search.png" alt="Search" width="200" style="margin: 10px;"/>
  <img src="screenshots/cart.png" alt="Shopping Cart" width="200" style="margin: 10px;"/>
  <img src="screenshots/normal_user_account.png" alt="User Account" width="200" style="margin: 10px;"/>
  <img src="screenshots/category.png" alt="category page" width="200" style="margin: 10px;"/>
  <img src="screenshots/detail_page.png" alt="detail page" width="200" style="margin: 10px;"/>
  <img src="screenshots/checkout.png" alt="Checkout " width="200" style="margin: 10px;"/>
  <img src="screenshots/order_confirmed.png" alt="Order Confirmation" width="200" style="margin: 10px;"/>

  <!-- <img src="screenshots/myorders.png" alt="My Orders" width="200" style="margin: 10px;"/> -->

</div>

### Authentication

<div style="display: flex; flex-wrap: wrap; justify-content: center;">
  <img src="screenshots/signin.png" alt="Sign In" width="200" style="margin: 10px;"/>
  <img src="screenshots/signup.png" alt="Sign Up" width="200" style="margin: 10px;"/>
</div>

### Admin Dashboard

<div style="display: flex; flex-wrap: wrap; justify-content: center;">
  <img src="screenshots/admin/admin_page.png" alt="Admin Dashboard" width="200" style="margin: 10px;"/>
  <img src="screenshots/admin/ad_product.png" alt="Add Product" width="200" style="margin: 10px;"/>
  <img src="screenshots/admin/category_page.png" alt="Category Management" width="200" style="margin: 10px;"/>
  <img src="screenshots/admin/order_management.png" alt="Order Management" width="200" style="margin: 10px;"/>
</div>

## ✨ Features

### For Customers
- **User Authentication** - Sign-up and sign-in functionality
- **Product Browsing** - Browse products by categories
- **Search Functionality** - Find products by name
- **Shopping Cart** - Add products in your cart
- **Order Placement** - Place orders with shipping address
- **Order History** - View past orders and their status
- **Address Management** - Save and manage shipping addresses

### For Vendors
- **Basic Product Management** - Add products with details
- **Order Management** - View orders for their products

### For Administrators
- **Category Management** - Create product categories with images
- **Product Management** - Add products to the platform
- **Order Oversight** - View all orders in the system

## 🛠️ Tech Stack

- **Frontend**: Flutter
- **State Management**: Flutter Bloc
- **Backend**: Supabase
- **Authentication**: Supabase Auth
- **Database**: PostgreSQL (via Supabase)
- **Storage**: Supabase Storage
- **Routing**: Go Router
- **UI Components**: Material Design


## 🗄️ Database Structure

The application uses Supabase (PostgreSQL) as its database with the following structure:

### User Roles

The system supports three user roles, defined in the `users` table:

- **Customer** - Default role for regular users who can browse products and make purchases
- **Vendor** - Can add products and view their orders
- **Admin** - Can manage categories, products, and view all orders

### Key Tables

- **users** - Stores user information including authentication details and role
- **products** - Contains product information linked to vendors and categories
- **categories** - Stores product categories
- **carts** - Manages shopping cart items for users
- **orders** - Tracks order information including status and payment details
  - Order statuses: pending, confirmed, delivered, cancelled
  - Payment statuses: paid, unpaid, refunded
  - Payment method: cash_on_delivery
- **order_items** - Contains individual items within an order
- **addresses** - Stores shipping addresses for users
- **product_images** - Contains images associated with products

### Custom Functions

The database includes custom PostgreSQL functions like `get_vendor_orders` that efficiently retrieve order data for vendors, including related product information and shipping details.

## 🚀 Getting Started

### Prerequisites

- Flutter SDK (3.6.2 or higher)
- Dart SDK (3.6.2 or higher)
- Supabase account
- IDE (VS Code, Android Studio, etc.)

### Installation

1. Clone the repository
   ```bash
   git clone https://github.com/sanam-tamang/flutter_ecommerce.git
   cd flutter_ecommerce
   ```

2. Install dependencies
   ```bash
   flutter pub get
   ```

3. Create a `.env` file in the root directory with your Supabase credentials
   ```
   SUPABASE_URL=your_supabase_url
   SUPABASE_ANNONKEY=your_supabase_anon_key
   ```

4. Run the app
   ```bash
   flutter run
   ```

## 📋 Project Structure

```
lib/
├── common/            # Common utilities, widgets, and theme
│   ├── theme/         # App theme configuration
│   ├── utils/         # Utility functions
│   └── widgets/       # Shared widgets
├── core/              # Core functionality and state management
│   ├── app/           # App initialization
│   ├── blocs/         # Global state management
│   ├── failure/       # Error handling
│   ├── repositories/  # Data access layer
│   └── state/         # State management utilities
├── features/          # Feature modules
│   ├── address/       # Address management
│   ├── auth/          # Authentication
│   ├── cart/          # Shopping cart
│   ├── category/      # Product categories
│   ├── home/          # Home page
│   ├── order/         # Order management
│   ├── product/       # Product browsing and details
│   ├── search/        # Search functionality
│   └── user/          # User profile and settings
├── main.dart          # Entry point
└── routes.dart        # App routes
```

Each feature follows a clean architecture pattern with:
- **blocs/** - State management
- **models/** - Data models
- **pages/** - UI screens
- **repositories/** - Data access
- **widgets/** - Feature-specific UI components

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📝 Features to be Added

The following features still need to be implemented:

- **User Profile Editing** - Allow users to edit their profile information
- **Enhanced Product Management** - More comprehensive product editing capabilities
- **Payment Gateway Integration** - Currently only cash on delivery is supported
- **Order Status Management** - Allow vendors/admins to update order status
- **User Management** - Admin functionality to manage users
- **Product Reviews** - Allow customers to rate and review products
- **UI Enhancements** - Improve the user interface and add animations
- **Wishlist** - Allow users to save products for later
- **Advanced Search** - Implement filters and sorting options

## 📞 Contact

Sanam Tamang

Project Link: [https://github.com/sanam-tamang/flutter_ecommerce](https://github.com/sanam-tamang/flutter_ecommerce)
