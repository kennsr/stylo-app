# Stylo App — API Contract

> **Version:** 1.0
> **Last Updated:** 2026-03-11
> **Base Path:** `/v1`
> **Content-Type:** `application/json` (all requests & responses)

---

## Table of Contents

1. [Environments & Base URLs](#1-environments--base-urls)
2. [Authentication](#2-authentication)
3. [Common Response Envelope](#3-common-response-envelope)
4. [Error Codes](#4-error-codes)
5. [Data Types / Interfaces](#5-data-types--interfaces)
6. [Endpoints](#6-endpoints)
   - [6.1 Auth](#61-auth)
   - [6.2 Home](#62-home)
   - [6.3 Products](#63-products)
   - [6.4 Cart](#64-cart)
   - [6.5 Checkout](#65-checkout)
   - [6.6 Orders](#66-orders)
   - [6.7 Profile](#67-profile)
   - [6.8 AI Try-On](#68-ai-try-on)
   - [6.9 Notifications](#69-notifications)
   - [6.10 Wishlist](#610-wishlist)
7. [Appendix A — Order Status Flow](#appendix-a-order-status-flow)
8. [Appendix B — Notification Types](#appendix-b-notification-types)
9. [Appendix C — Size Format Conventions](#appendix-c-size-format-conventions)
10. [Appendix D — Currency](#appendix-d-currency)
11. [Appendix E — JSON Field Mapping (Flutter ↔ API)](#appendix-e-json-field-mapping-flutter--api)

---

## 1. Environments & Base URLs

| Environment    | Base URL                                         |
| -------------- | ------------------------------------------------ |
| **Mock**       | `https://04d3-182-253-251-196.ngrok-free.app/v1` |
| **Dev**        | `https://04d3-182-253-251-196.ngrok-free.app/v1` |
| **Staging**    | `https://staging-api.stylo.id/v1`                |
| **Production** | `https://api.stylo.id/v1`                        |

Configured in `lib/core/constants/api_constants.dart` via `EnvConfig.current`.

---

## 2. Authentication

All protected endpoints require a **Bearer token** in the `Authorization` header:

```
Authorization: Bearer <token>
```

The token is obtained from `POST /auth/login` or `POST /auth/register` and persisted in `SharedPreferences` on the device.

**Public endpoints** (no auth required):

- `POST /auth/login`
- `POST /auth/register`

All other endpoints require authentication.

---

## 3. Common Response Envelope

Every API response — success or error — is wrapped in this envelope:

```json
{
  "message": "Success",
  "data": <payload>
}
```

| Field     | Type                      | Description                                           |
| --------- | ------------------------- | ----------------------------------------------------- |
| `message` | `String`                  | Human-readable status message (Indonesian or English) |
| `data`    | `Object \| Array \| null` | The response payload; `null` for no-content responses |

---

## 4. Error Codes

| HTTP Status | Meaning               | App Behaviour                                |
| ----------- | --------------------- | -------------------------------------------- |
| `200`       | OK                    | Parse `data` field normally                  |
| `201`       | Created               | Parse `data` field normally                  |
| `400`       | Bad Request           | Show validation error from `message`         |
| `401`       | Unauthorized          | Clear stored token, redirect to Login screen |
| `404`       | Not Found             | Show empty state or not-found UI             |
| `422`       | Unprocessable Entity  | Show field-level validation errors           |
| `500`       | Internal Server Error | Show generic error screen with retry         |

**Error response body:**

```json
{
  "message": "Pesan error yang dapat dibaca pengguna",
  "errors": {
    "email": ["Email sudah terdaftar"],
    "password": ["Password minimal 8 karakter"]
  }
}
```

---

## 5. Data Types / Interfaces

### 5.1 User

```typescript
interface User {
  id: string; // e.g. "user_rizki_01"
  email: string;
  name: string;
  phone: string | null;
  avatar_url: string | null;
  style_preferences: string[]; // e.g. ["Casual", "Streetwear"]
  token?: string; // only present on login / register responses
}
```

### 5.2 Banner

```typescript
interface Banner {
  id: string;
  image_url: string; // 800×400 landscape image
  title: string | null;
  subtitle: string | null;
  deep_link: string | null; // e.g. "/products", "/products?category=Dress"
}
```

### 5.3 Category

```typescript
interface Category {
  id: string; // e.g. "cat_pria"
  name: string; // e.g. "Pakaian Pria"
  icon_url: string | null;
  slug: string | null;
}
```

### 5.4 ProductVariant

```typescript
interface ProductVariant {
  id: string; // e.g. "var_0_1"
  size: string; // e.g. "S", "M", "L", "XL", "36", "40cm", "ONE SIZE"
  color: string; // e.g. "Putih", "Hitam", "Navy"
  stock: number; // integer
  additional_price: number | null; // surcharge on top of base price; usually null
}
```

### 5.5 Product (List / Summary)

```typescript
interface ProductSummary {
  id: string; // e.g. "prod_0"
  name: string;
  description: string;
  price: number; // IDR, e.g. 189000.0
  discount_price: number | null; // null if no discount
  image_url: string; // single cover image
  category: string; // matches Category.name
  rating: number; // 0.0 – 5.0
  reviews_count: number; // integer total review count
  has_ai_try_on: boolean;
  stock: number; // total available stock
  is_featured: boolean;
  variants: ProductVariant[];
}
```

> ⚠️ The Flutter app reads `reviews_count` (snake_case with trailing `s`). Do **not** use `review_count`.

### 5.6 Product (Detail)

Extends `ProductSummary` with an array of gallery images:

```typescript
interface ProductDetail extends ProductSummary {
  images: string[]; // 4-image array; index 0 matches image_url
}
```

### 5.7 Review

```typescript
interface Review {
  id: string;
  user_id: string;
  user_name: string;
  user_avatar: string | null;
  rating: number; // 1 – 5
  comment: string;
  created_at: string; // ISO 8601, e.g. "2026-03-09T10:30:00.000Z"
  images: string[]; // optional review photo URLs
}
```

### 5.8 CartItem

```typescript
interface CartItem {
  id: string; // cart line-item ID
  product_id: string;
  product_name: string;
  product_image: string;
  price: number; // IDR unit price
  quantity: number; // integer ≥ 1
  size: string;
  color: string;
  discount_price: number | null;
}
```

### 5.9 Cart

```typescript
interface Cart {
  items: CartItem[];
  subtotal: number; // IDR sum of (price × quantity) for all items
  total: number; // IDR after discounts
}
```

### 5.10 ShippingAddress

```typescript
interface ShippingAddress {
  id: string;
  label: string | null; // e.g. "Rumah", "Kantor"
  receiver_name: string; // recipient full name
  phone: string;
  street: string; // street / detail address line
  city: string;
  province: string;
  postal_code: string;
  is_default: boolean;
}
```

### 5.11 ShippingOption

```typescript
interface ShippingOption {
  id: string;
  courier: string; // e.g. "JNE", "SiCepat"
  service: string; // e.g. "Reguler", "OKE", "BEST"
  cost: number; // IDR shipping fee
  estimated_days: number; // integer working days (not a string)
}
```

### 5.12 PaymentMethod

```typescript
interface PaymentMethod {
  id: string;
  name: string; // e.g. "GoPay", "BCA Virtual Account"
  type: string; // "ewallet" | "virtual_account" | "credit_card"
  icon_url: string | null;
}
```

### 5.13 CartItemRef (inside PlacedOrder)

```typescript
interface CartItemRef {
  product_id: string;
  product_name: string;
  quantity: number;
  price: number;
  size: string;
  color: string;
  product_image: string | null;
}
```

### 5.14 PlacedOrder (Place Order response)

```typescript
interface PlacedOrder {
  id: string;
  order_number: string; // e.g. "STY-2026031101"
  items: CartItemRef[];
  address: ShippingAddress;
  shipping: ShippingOption;
  payment_method: string;
  subtotal: number;
  shipping_cost: number;
  total: number;
  status: OrderStatus;
  created_at: string; // ISO 8601
  payment_info: PaymentInfo | null;
}
```

### 5.15 OrderSummary (for Orders list screen)

```typescript
interface OrderSummary {
  id: string;
  order_number: string;
  item_count: number;
  total: number;
  status: OrderStatus;
  created_at: string; // ISO 8601
  first_item_image: string | null;
  first_item_name: string | null;
}
```

### 5.16 OrderStatus (enum string)

```
"menunggu_pembayaran"  — Awaiting payment
"diproses"             — Seller is processing / packing
"dikirim"              — Shipped, in transit
"selesai"              — Delivered & completed
"dibatalkan"           — Cancelled
```

### 5.17 OrderDetail

```typescript
interface OrderDetail {
  id: string;
  order_number: string;
  status: OrderStatus;
  subtotal: number;
  shipping_cost: number;
  discount: number; // discount amount; 0 if none
  total: number;
  payment_method: string;
  payment_info: PaymentInfo | null;
  shipping_courier: string;
  shipping_service: string;
  tracking_number: string | null;
  receiver_name: string;
  address: string; // pre-formatted single-line address string
  phone: string;
  created_at: string; // ISO 8601
  items: OrderItem[];
}

interface OrderItem {
  product_id: string;
  product_name: string;
  quantity: number;
  price: number;
  size: string;
  color: string;
  product_image: string | null;
}

interface PaymentInfo {
  virtual_account_number: string | null;
  expires_at: string | null; // ISO 8601
}
```

### 5.18 StylePreference

```typescript
interface StylePreference {
  id: string;
  name: string; // e.g. "Casual", "Streetwear", "Formal"
  is_selected: boolean; // true if the current user has selected this
}
```

### 5.19 FitProfile

```typescript
interface FitProfile {
  user_id: string | null;
  height: number | null; // cm
  weight: number | null; // kg
  chest: number | null; // cm
  waist: number | null; // cm
  hips: number | null; // cm
  preferred_size: string | null; // e.g. "M", "L"
}
```

### 5.20 TryOnResult

```typescript
interface TryOnResult {
  id: string;
  product_id: string;
  original_image_url: string;
  result_image_url: string;
  created_at: string; // ISO 8601
  is_saved: boolean;
}
```

### 5.21 TryOnGenerateResponse

```typescript
interface TryOnGenerateResponse {
  task_id: string;
  status: "processing" | "completed" | "failed";
  result_image_url?: string; // present when status = "completed"
}
```

### 5.22 NotificationItem

```typescript
interface NotificationItem {
  id: string;
  title: string;
  body: string;
  type: NotificationType; // see Appendix B
  is_read: boolean;
  created_at: string; // ISO 8601
  image_url: string | null;
  action_route: string | null; // deep-link, e.g. "/orders/ord_003"
}

type NotificationType = "promo" | "order_update" | "system";
```

### 5.23 WishlistState

> Wishlist is **local-only in v1** (stored in SharedPreferences). These types define the future v2 server-sync interface.

```typescript
interface WishlistState {
  product_ids: string[]; // array of product IDs the user has wishlisted
}
```

---

## 6. Endpoints

---

### 6.1 Auth

#### `POST /auth/login`

Authenticates a user by email + password and returns a session token.

**Auth required:** ❌ Public

**Request body:**

```json
{
  "email": "rizki.pratama@gmail.com",
  "password": "password123"
}
```

| Field      | Type     | Required | Notes              |
| ---------- | -------- | -------- | ------------------ |
| `email`    | `String` | ✅       | Valid email format |
| `password` | `String` | ✅       | Min 6 characters   |

**Response `200`:**

```json
{
  "message": "Login berhasil",
  "data": {
    "id": "user_rizki_01",
    "email": "rizki.pratama@gmail.com",
    "name": "Rizki Pratama",
    "phone": "081234567890",
    "avatar_url": "https://cdn.stylo.id/avatars/user_rizki_01.jpg",
    "style_preferences": ["Casual", "Streetwear"],
    "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9..."
  }
}
```

---

#### `POST /auth/register`

Creates a new user account and returns a session token.

**Auth required:** ❌ Public

**Request body:**

```json
{
  "name": "Rizki Pratama",
  "email": "rizki.pratama@gmail.com",
  "password": "password123"
}
```

| Field      | Type     | Required | Notes             |
| ---------- | -------- | -------- | ----------------- |
| `name`     | `String` | ✅       | Full display name |
| `email`    | `String` | ✅       | Must be unique    |
| `password` | `String` | ✅       | Min 8 characters  |

**Response `201`:** Same shape as Login `200`.

---

#### `POST /auth/logout`

Invalidates the current session token server-side.

**Auth required:** ✅

**Request body:** None

**Response `200`:**

```json
{
  "message": "Logout berhasil",
  "data": null
}
```

---

#### `GET /auth/me`

Returns the currently authenticated user's full profile.

**Auth required:** ✅

**Response `200`:**

```json
{
  "message": "Success",
  "data": {
    "id": "user_rizki_01",
    "email": "rizki.pratama@gmail.com",
    "name": "Rizki Pratama",
    "phone": "081234567890",
    "avatar_url": "https://cdn.stylo.id/avatars/user_rizki_01.jpg",
    "style_preferences": ["Casual", "Streetwear"]
  }
}
```

---

### 6.2 Home

#### `GET /home/banners`

Returns promotional banner images for the home screen carousel.

**Auth required:** ✅

**Response `200`:**

```json
{
  "message": "Success",
  "data": [
    {
      "id": "banner_1",
      "image_url": "https://cdn.stylo.id/banners/harbolnas.jpg",
      "title": "Harbolnas Sale",
      "subtitle": "Diskon s/d 70%!",
      "deep_link": "/products"
    },
    {
      "id": "banner_2",
      "image_url": "https://cdn.stylo.id/banners/lebaran.jpg",
      "title": "Koleksi Lebaran",
      "subtitle": "Tampil Memukau di Hari Raya",
      "deep_link": "/products?category=Dress"
    }
  ]
}
```

---

### 6.3 Products

#### `GET /products/categories`

Returns the list of product categories.

**Auth required:** ✅

**Response `200`:**

```json
{
  "message": "Success",
  "data": [
    {
      "id": "cat_pria",
      "name": "Pakaian Pria",
      "icon_url": "https://cdn.stylo.id/icons/pria.png",
      "slug": "pakaian-pria"
    },
    {
      "id": "cat_wanita",
      "name": "Pakaian Wanita",
      "icon_url": "https://cdn.stylo.id/icons/wanita.png",
      "slug": "pakaian-wanita"
    },
    {
      "id": "cat_dress",
      "name": "Dress",
      "icon_url": "https://cdn.stylo.id/icons/dress.png",
      "slug": "dress"
    },
    {
      "id": "cat_outer",
      "name": "Outerwear",
      "icon_url": "https://cdn.stylo.id/icons/outer.png",
      "slug": "outerwear"
    },
    {
      "id": "cat_aksesoris",
      "name": "Aksesoris",
      "icon_url": "https://cdn.stylo.id/icons/aksesoris.png",
      "slug": "aksesoris"
    },
    {
      "id": "cat_sepatu",
      "name": "Sepatu",
      "icon_url": "https://cdn.stylo.id/icons/sepatu.png",
      "slug": "sepatu"
    }
  ]
}
```

---

#### `GET /products`

Returns a paginated list of products. Supports category filter, text search, and featured flag.

**Auth required:** ✅

**Query Parameters:**

| Parameter  | Type      | Required | Default | Description                                           |
| ---------- | --------- | -------- | ------- | ----------------------------------------------------- |
| `page`     | `integer` | No       | `1`     | Page number (1-indexed)                               |
| `pageSize` | `integer` | No       | `20`    | Items per page (max 50)                               |
| `category` | `string`  | No       | —       | Filter by category name, e.g. `"Pakaian Pria"`        |
| `search`   | `string`  | No       | —       | Full-text search on `name` and `description`          |
| `featured` | `boolean` | No       | —       | `"true"` to return only `is_featured = true` products |

**Response `200`:**

```json
{
  "message": "Success",
  "data": [
    {
      "id": "prod_0",
      "name": "Kemeja Oxford Slim Fit",
      "description": "Kemeja Oxford premium dengan potongan slim fit yang modern dan elegan...",
      "price": 189000.0,
      "discount_price": null,
      "image_url": "https://cdn.stylo.id/products/kemeja_oxford.jpg",
      "category": "Pakaian Pria",
      "rating": 4.7,
      "reviews_count": 312,
      "has_ai_try_on": true,
      "stock": 45,
      "is_featured": true,
      "variants": [
        {
          "id": "var_0_1",
          "size": "S",
          "color": "Putih",
          "stock": 8,
          "additional_price": null
        },
        {
          "id": "var_0_2",
          "size": "M",
          "color": "Putih",
          "stock": 12,
          "additional_price": null
        },
        {
          "id": "var_0_3",
          "size": "L",
          "color": "Putih",
          "stock": 10,
          "additional_price": null
        }
      ]
    }
  ]
}
```

---

#### `GET /products/search`

Searches products by keyword. Matches against `name` and `description`.

**Auth required:** ✅

**Query Parameters:**

| Parameter | Type     | Required | Description                      |
| --------- | -------- | -------- | -------------------------------- |
| `q`       | `string` | ✅       | Search keyword (min 1 character) |

**Response `200`:** Same array shape as `GET /products`.

---

#### `GET /products/:id`

Returns the full product detail including all gallery images.

**Auth required:** ✅

**Path Parameters:**

| Parameter | Type     | Description                 |
| --------- | -------- | --------------------------- |
| `id`      | `string` | Product ID, e.g. `"prod_0"` |

**Response `200`:**

```json
{
  "message": "Success",
  "data": {
    "id": "prod_0",
    "name": "Kemeja Oxford Slim Fit",
    "description": "Kemeja Oxford premium dengan potongan slim fit yang modern dan elegan. Dibuat dari bahan katun Oxford berkualitas tinggi yang nyaman dipakai sepanjang hari. Cocok untuk tampilan kasual sehari-hari maupun acara semi-formal.",
    "price": 189000.0,
    "discount_price": null,
    "image_url": "https://cdn.stylo.id/products/kemeja_oxford_1.jpg",
    "images": [
      "https://cdn.stylo.id/products/kemeja_oxford_1.jpg",
      "https://cdn.stylo.id/products/kemeja_oxford_2.jpg",
      "https://cdn.stylo.id/products/kemeja_oxford_3.jpg",
      "https://cdn.stylo.id/products/kemeja_oxford_4.jpg"
    ],
    "category": "Pakaian Pria",
    "rating": 4.7,
    "reviews_count": 312,
    "has_ai_try_on": true,
    "stock": 45,
    "is_featured": true,
    "variants": [
      {
        "id": "var_0_1",
        "size": "S",
        "color": "Putih",
        "stock": 8,
        "additional_price": null
      },
      {
        "id": "var_0_2",
        "size": "M",
        "color": "Putih",
        "stock": 12,
        "additional_price": null
      },
      {
        "id": "var_0_3",
        "size": "L",
        "color": "Putih",
        "stock": 10,
        "additional_price": null
      },
      {
        "id": "var_0_4",
        "size": "XL",
        "color": "Putih",
        "stock": 5,
        "additional_price": null
      },
      {
        "id": "var_0_5",
        "size": "S",
        "color": "Hitam",
        "stock": 6,
        "additional_price": null
      },
      {
        "id": "var_0_6",
        "size": "M",
        "color": "Hitam",
        "stock": 9,
        "additional_price": null
      }
    ]
  }
}
```

**Response `404`:** Product not found.

---

#### `GET /products/:id/reviews`

Returns paginated customer reviews for a product.

**Auth required:** ✅

**Path Parameters:**

| Parameter | Type     | Description |
| --------- | -------- | ----------- |
| `id`      | `string` | Product ID  |

**Query Parameters:**

| Parameter  | Type      | Default | Description      |
| ---------- | --------- | ------- | ---------------- |
| `page`     | `integer` | `1`     | Page number      |
| `pageSize` | `integer` | `10`    | Reviews per page |

**Response `200`:**

```json
{
  "message": "Success",
  "data": [
    {
      "id": "rev_001",
      "user_id": "user_siti_01",
      "user_name": "Siti Rahma",
      "user_avatar": "https://i.pravatar.cc/80?u=siti_rahma",
      "rating": 5,
      "comment": "Produk sangat bagus dan sesuai deskripsi! Kualitas bahan premium, pengiriman cepat. Pasti beli lagi di Stylo, recommended banget!",
      "created_at": "2026-03-09T10:30:00.000Z",
      "images": []
    },
    {
      "id": "rev_002",
      "user_id": "user_budi_01",
      "user_name": "Budi Santoso",
      "user_avatar": "https://i.pravatar.cc/80?u=budi_santoso",
      "rating": 4,
      "comment": "Kualitas bagus, bahan nyaman dipakai. Ukurannya sesuai chart, pas di badan.",
      "created_at": "2026-03-06T08:00:00.000Z",
      "images": []
    }
  ]
}
```

---

### 6.4 Cart

> The Flutter app manages the cart **locally via Drift (SQLite)** for offline support. These endpoints exist for server-side sync.

#### `GET /cart`

Returns the authenticated user's current server-side cart.

**Auth required:** ✅

**Response `200`:**

```json
{
  "message": "Success",
  "data": {
    "items": [
      {
        "id": "cart_item_1",
        "product_id": "prod_1",
        "product_name": "Kaos Oversize Streetwear",
        "product_image": "https://cdn.stylo.id/products/kaos_oversize.jpg",
        "price": 129000.0,
        "quantity": 2,
        "size": "L",
        "color": "Hitam",
        "discount_price": null
      }
    ],
    "subtotal": 258000.0,
    "total": 258000.0
  }
}
```

---

#### `POST /cart/items`

Adds an item to the cart. If the same `product_id` + `size` + `color` combination already exists, the server should increment its quantity.

**Auth required:** ✅

**Request body:**

```json
{
  "product_id": "prod_0",
  "product_name": "Kemeja Oxford Slim Fit",
  "product_image": "https://cdn.stylo.id/products/kemeja_oxford.jpg",
  "price": 189000.0,
  "quantity": 1,
  "size": "M",
  "color": "Putih",
  "discount_price": null
}
```

| Field            | Type             | Required | Notes                      |
| ---------------- | ---------------- | -------- | -------------------------- |
| `product_id`     | `String`         | ✅       |                            |
| `product_name`   | `String`         | ✅       | Snapshot at time of adding |
| `product_image`  | `String`         | ✅       | Snapshot at time of adding |
| `price`          | `Number`         | ✅       | Unit price in IDR          |
| `quantity`       | `Integer`        | ✅       | Min 1                      |
| `size`           | `String`         | ✅       |                            |
| `color`          | `String`         | ✅       |                            |
| `discount_price` | `Number \| null` | No       |                            |

**Response `200`:** Updated cart (same as `GET /cart` response).

---

#### `PUT /cart/items/:itemId`

Updates the quantity of a specific cart line item.

**Auth required:** ✅

**Path Parameters:**

| Parameter | Type     | Description       |
| --------- | -------- | ----------------- |
| `itemId`  | `string` | Cart line-item ID |

**Request body:**

```json
{
  "quantity": 3
}
```

| Field      | Type      | Required | Notes                                   |
| ---------- | --------- | -------- | --------------------------------------- |
| `quantity` | `Integer` | ✅       | Min 1; send `0` or use DELETE to remove |

**Response `200`:** Updated cart.

---

#### `DELETE /cart/items/:itemId`

Removes a single line item from the cart.

**Auth required:** ✅

**Path Parameters:**

| Parameter | Type     | Description       |
| --------- | -------- | ----------------- |
| `itemId`  | `string` | Cart line-item ID |

**Response `200`:** Updated cart.

---

### 6.5 Checkout

#### `GET /checkout/addresses`

Returns saved shipping addresses for the current user.

**Auth required:** ✅

**Response `200`:**

```json
{
  "message": "Success",
  "data": [
    {
      "id": "addr_1",
      "label": "Rumah",
      "receiver_name": "Rizki Pratama",
      "phone": "081234567890",
      "street": "Jl. Kemang Raya No. 15, RT 03/RW 07",
      "city": "Jakarta Selatan",
      "province": "DKI Jakarta",
      "postal_code": "12730",
      "is_default": true
    },
    {
      "id": "addr_2",
      "label": "Kantor",
      "receiver_name": "Rizki Pratama",
      "phone": "081234567890",
      "street": "Jl. Jend. Sudirman Kav. 52-53, Senayan",
      "city": "Jakarta Pusat",
      "province": "DKI Jakarta",
      "postal_code": "10270",
      "is_default": false
    }
  ]
}
```

---

#### `GET /checkout/shipping-rates`

Returns available shipping couriers and rates for the selected address and cart weight.

**Auth required:** ✅

**Query Parameters:**

| Parameter    | Type     | Required | Description                         |
| ------------ | -------- | -------- | ----------------------------------- |
| `address_id` | `string` | ✅       | ID of the selected shipping address |
| `weight`     | `number` | ✅       | Total cart weight in kg             |

**Response `200`:**

```json
{
  "message": "Success",
  "data": [
    {
      "id": "ship_jne_reg",
      "courier": "JNE",
      "service": "Reguler",
      "cost": 15000.0,
      "estimated_days": 3
    },
    {
      "id": "ship_jne_oke",
      "courier": "JNE",
      "service": "OKE",
      "cost": 9000.0,
      "estimated_days": 5
    },
    {
      "id": "ship_sicepat",
      "courier": "SiCepat",
      "service": "BEST",
      "cost": 22000.0,
      "estimated_days": 2
    }
  ]
}
```

---

#### `GET /checkout/payment-methods`

Returns the payment methods available to the current user.

**Auth required:** ✅

**Response `200`:**

```json
{
  "message": "Success",
  "data": [
    {
      "id": "pay_gopay",
      "name": "GoPay",
      "type": "ewallet",
      "icon_url": "https://cdn.stylo.id/icons/gopay.png"
    },
    {
      "id": "pay_ovo",
      "name": "OVO",
      "type": "ewallet",
      "icon_url": "https://cdn.stylo.id/icons/ovo.png"
    },
    {
      "id": "pay_bca",
      "name": "BCA Virtual Account",
      "type": "virtual_account",
      "icon_url": "https://cdn.stylo.id/icons/bca.png"
    },
    {
      "id": "pay_mandiri",
      "name": "Mandiri Virtual Account",
      "type": "virtual_account",
      "icon_url": "https://cdn.stylo.id/icons/mandiri.png"
    }
  ]
}
```

---

#### `POST /checkout/place-order`

Creates an order from the current user's cart. The server reads the cart server-side; the client passes only address, shipping, and payment selections. The cart is cleared server-side on success.

**Auth required:** ✅

**Request body:**

```json
{
  "address_id": "addr_1",
  "shipping_option_id": "ship_jne_reg",
  "payment_method": "GoPay"
}
```

| Field                | Type     | Required | Notes                                     |
| -------------------- | -------- | -------- | ----------------------------------------- |
| `address_id`         | `String` | ✅       | Must belong to the authenticated user     |
| `shipping_option_id` | `String` | ✅       | ID from `/checkout/shipping-rates`        |
| `payment_method`     | `String` | ✅       | Payment method name or ID, e.g. `"GoPay"` |

**Response `200`:**

```json
{
  "message": "Pesanan berhasil dibuat",
  "data": {
    "id": "ord_12345",
    "order_number": "STY-2026031101",
    "items": [
      {
        "product_id": "prod_0",
        "product_name": "Kemeja Oxford Slim Fit",
        "quantity": 1,
        "price": 189000.0,
        "size": "M",
        "color": "Putih",
        "product_image": "https://cdn.stylo.id/products/kemeja_oxford.jpg"
      }
    ],
    "address": {
      "id": "addr_1",
      "label": "Rumah",
      "receiver_name": "Rizki Pratama",
      "phone": "081234567890",
      "street": "Jl. Kemang Raya No. 15",
      "city": "Jakarta Selatan",
      "province": "DKI Jakarta",
      "postal_code": "12730",
      "is_default": true
    },
    "shipping": {
      "id": "ship_jne_reg",
      "courier": "JNE",
      "service": "Reguler",
      "cost": 15000.0,
      "estimated_days": 3
    },
    "payment_method": "GoPay",
    "subtotal": 189000.0,
    "shipping_cost": 15000.0,
    "total": 204000.0,
    "status": "menunggu_pembayaran",
    "created_at": "2026-03-11T10:00:00.000Z",
    "payment_info": {
      "virtual_account_number": "8800123456789",
      "expires_at": "2026-03-12T10:00:00.000Z"
    }
  }
}
```

---

### 6.6 Orders

#### `GET /orders`

Returns all orders for the current user, sorted newest-first.

**Auth required:** ✅

**Response `200`:**

```json
{
  "message": "Success",
  "data": [
    {
      "id": "ord_001",
      "order_number": "STY-2026031101",
      "item_count": 2,
      "total": 345000.0,
      "status": "menunggu_pembayaran",
      "created_at": "2026-03-11T09:00:00.000Z",
      "first_item_image": "https://cdn.stylo.id/products/kemeja_oxford.jpg",
      "first_item_name": "Kemeja Oxford Slim Fit"
    },
    {
      "id": "ord_003",
      "order_number": "STY-2026030701",
      "item_count": 3,
      "total": 567000.0,
      "status": "dikirim",
      "created_at": "2026-03-07T08:00:00.000Z",
      "first_item_image": "https://cdn.stylo.id/products/hoodie_fleece.jpg",
      "first_item_name": "Hoodie Fleece Tebal"
    }
  ]
}
```

---

#### `GET /orders/:orderId`

Returns the full detail of a single order.

**Auth required:** ✅

**Path Parameters:**

| Parameter | Type     | Description |
| --------- | -------- | ----------- |
| `orderId` | `string` | Order ID    |

**Response `200`:**

```json
{
  "message": "Success",
  "data": {
    "id": "ord_001",
    "order_number": "STY-2026031101",
    "status": "menunggu_pembayaran",
    "subtotal": 318000.0,
    "shipping_cost": 15000.0,
    "discount": 0.0,
    "total": 333000.0,
    "payment_method": "GoPay",
    "payment_info": {
      "virtual_account_number": "8800123456789",
      "expires_at": "2026-03-12T09:00:00.000Z"
    },
    "shipping_courier": "JNE",
    "shipping_service": "Reguler",
    "tracking_number": null,
    "receiver_name": "Rizki Pratama",
    "address": "Jl. Kemang Raya No. 15, RT 03/RW 07, Jakarta Selatan 12730",
    "phone": "081234567890",
    "created_at": "2026-03-11T09:00:00.000Z",
    "items": [
      {
        "product_id": "prod_0",
        "product_name": "Kemeja Oxford Slim Fit",
        "quantity": 1,
        "price": 189000.0,
        "size": "M",
        "color": "Putih",
        "product_image": "https://cdn.stylo.id/products/kemeja_oxford.jpg"
      },
      {
        "product_id": "prod_11",
        "product_name": "Topi Bucket Hat",
        "quantity": 1,
        "price": 79000.0,
        "size": "ONE SIZE",
        "color": "Navy",
        "product_image": "https://cdn.stylo.id/products/bucket_hat.jpg"
      }
    ]
  }
}
```

**Response `404`:** Order not found.

---

### 6.7 Profile

#### `GET /profile`

Returns the full profile of the authenticated user.

**Auth required:** ✅

**Response `200`:**

```json
{
  "message": "Success",
  "data": {
    "id": "user_rizki_01",
    "email": "rizki.pratama@gmail.com",
    "name": "Rizki Pratama",
    "phone": "081234567890",
    "avatar_url": "https://cdn.stylo.id/avatars/user_rizki_01.jpg",
    "style_preferences": ["Casual", "Streetwear"]
  }
}
```

---

#### `PUT /profile`

Updates the user's basic profile fields (name, phone).

**Auth required:** ✅

**Request body:**

```json
{
  "name": "Rizki Pratama Updated",
  "phone": "081298765432"
}
```

| Field   | Type             | Required | Notes |
| ------- | ---------------- | -------- | ----- |
| `name`  | `String`         | ✅       |       |
| `phone` | `String \| null` | No       |       |

**Response `200`:** Updated user profile (same as `GET /profile`).

---

#### `GET /profile/style-preferences`

Returns all available style preference options with the user's current selections.

**Auth required:** ✅

**Response `200`:**

```json
{
  "message": "Success",
  "data": [
    { "id": "pref_casual", "name": "Casual", "is_selected": true },
    { "id": "pref_streetwear", "name": "Streetwear", "is_selected": true },
    { "id": "pref_formal", "name": "Formal", "is_selected": false },
    { "id": "pref_sporty", "name": "Sporty", "is_selected": false },
    { "id": "pref_bohemian", "name": "Bohemian", "is_selected": false },
    { "id": "pref_minimalist", "name": "Minimalist", "is_selected": false },
    { "id": "pref_vintage", "name": "Vintage", "is_selected": false }
  ]
}
```

---

#### `PUT /profile/style-preferences`

Replaces the user's entire style preferences selection.

**Auth required:** ✅

**Request body:**

```json
{
  "preference_ids": ["pref_casual", "pref_minimalist"]
}
```

| Field            | Type       | Required | Notes                                             |
| ---------------- | ---------- | -------- | ------------------------------------------------- |
| `preference_ids` | `String[]` | ✅       | Full replacement — unspecified IDs are deselected |

**Response `200`:**

```json
{
  "message": "Preferensi gaya berhasil diperbarui",
  "data": null
}
```

---

#### `GET /profile/fit-profile`

Returns the user's body measurement data used by the AI try-on engine.

**Auth required:** ✅

**Response `200`:**

```json
{
  "message": "Success",
  "data": {
    "user_id": "user_rizki_01",
    "height": 175.0,
    "weight": 70.0,
    "chest": 95.0,
    "waist": 80.0,
    "hips": 90.0,
    "preferred_size": "L"
  }
}
```

Returns `null` for `data` if the user has never set up a fit profile.

---

#### `PUT /profile/fit-profile`

Creates or fully replaces the user's body measurement profile.

**Auth required:** ✅

**Request body:**

```json
{
  "height": 175.0,
  "weight": 70.0,
  "chest": 95.0,
  "waist": 80.0,
  "hips": 90.0,
  "preferred_size": "L"
}
```

| Field            | Type             | Required | Notes                     |
| ---------------- | ---------------- | -------- | ------------------------- |
| `height`         | `Number \| null` | No       | cm                        |
| `weight`         | `Number \| null` | No       | kg                        |
| `chest`          | `Number \| null` | No       | cm                        |
| `waist`          | `Number \| null` | No       | cm                        |
| `hips`           | `Number \| null` | No       | cm                        |
| `preferred_size` | `String \| null` | No       | e.g. `"M"`, `"L"`, `"XL"` |

**Response `200`:** Updated fit profile (same as `GET /profile/fit-profile`).

---

### 6.8 AI Try-On

#### `POST /try-on/generate`

Submits a user photo to the AI engine for virtual try-on generation. This is **asynchronous** — the response returns a `task_id` and the result is delivered via notification or polling `GET /try-on/results`.

**Auth required:** ✅

**Request body:**

```json
{
  "product_id": "prod_0",
  "photo": "<base64_encoded_jpeg_or_png>"
}
```

| Field        | Type     | Required | Notes                               |
| ------------ | -------- | -------- | ----------------------------------- |
| `product_id` | `String` | ✅       | Must have `has_ai_try_on: true`     |
| `photo`      | `String` | ✅       | Base64-encoded JPG or PNG, max 5 MB |

**Response `200`:**

```json
{
  "message": "Try-on task sedang diproses",
  "data": {
    "task_id": "task_abc123",
    "status": "processing"
  }
}
```

---

#### `GET /try-on/avatars`

Returns pre-built mannequin avatar options that users can try clothes on without uploading a photo.

**Auth required:** ✅

**Response `200`:**

```json
{
  "message": "Success",
  "data": [
    {
      "id": "avatar_1",
      "name": "Avatar Pria 1",
      "image_url": "https://cdn.stylo.id/avatars/avatar_m1.png"
    },
    {
      "id": "avatar_2",
      "name": "Avatar Wanita 1",
      "image_url": "https://cdn.stylo.id/avatars/avatar_f1.png"
    }
  ]
}
```

---

#### `GET /try-on/results`

Returns the current user's try-on history.

**Auth required:** ✅

**Response `200`:**

```json
{
  "message": "Success",
  "data": [
    {
      "id": "tryon_001",
      "product_id": "prod_0",
      "original_image_url": "https://cdn.stylo.id/try-on/orig_001.jpg",
      "result_image_url": "https://cdn.stylo.id/try-on/result_001.jpg",
      "created_at": "2026-03-10T14:00:00.000Z",
      "is_saved": false
    }
  ]
}
```

---

### 6.9 Notifications

#### `GET /notifications`

Returns all notifications for the current user, sorted newest-first.

**Auth required:** ✅

**Response `200`:**

```json
{
  "message": "Success",
  "data": [
    {
      "id": "notif_001",
      "title": "Flash Sale Hari Ini!",
      "body": "Diskon 50% untuk semua item fashion wanita. Jangan sampai ketinggalan!",
      "type": "promo",
      "is_read": false,
      "created_at": "2026-03-11T08:00:00.000Z",
      "image_url": "https://cdn.stylo.id/banners/flash_sale.jpg",
      "action_route": "/products?category=Pakaian Wanita"
    },
    {
      "id": "notif_002",
      "title": "Pesanan Dikirim",
      "body": "Pesanan STY-2026030701 sedang dalam perjalanan. Lacak sekarang!",
      "type": "order_update",
      "is_read": false,
      "created_at": "2026-03-09T09:00:00.000Z",
      "image_url": null,
      "action_route": "/orders/ord_003"
    },
    {
      "id": "notif_003",
      "title": "Selamat Datang di Stylo!",
      "body": "Akun kamu berhasil dibuat. Mulai belanja fashion pilihan kamu sekarang.",
      "type": "system",
      "is_read": true,
      "created_at": "2026-03-01T10:00:00.000Z",
      "image_url": null,
      "action_route": null
    }
  ]
}
```

---

#### `PATCH /notifications/:id/read`

Marks a single notification as read.

**Auth required:** ✅

**Path Parameters:**

| Parameter | Type     | Description     |
| --------- | -------- | --------------- |
| `id`      | `string` | Notification ID |

**Request body:** None (empty)

**Response `200`:**

```json
{
  "message": "Notifikasi ditandai telah dibaca",
  "data": null
}
```

---

#### `PATCH /notifications/read-all`

Marks **all** notifications for the current user as read.

**Auth required:** ✅

**Request body:** None (empty)

**Response `200`:**

```json
{
  "message": "Semua notifikasi ditandai telah dibaca",
  "data": null
}
```

---

### 6.10 Wishlist

> **v1 Note:** Wishlist is managed **locally on-device** via SharedPreferences. The API endpoints below are defined for future v2 server-sync and are **not called** by the current app version.

#### `GET /wishlist`

Returns the product IDs the user has added to their wishlist.

**Auth required:** ✅

**Response `200`:**

```json
{
  "message": "Success",
  "data": {
    "product_ids": ["prod_0", "prod_3", "prod_7"]
  }
}
```

---

#### `POST /wishlist`

Adds a product to the server wishlist.

**Auth required:** ✅

**Request body:**

```json
{
  "product_id": "prod_0"
}
```

**Response `200`:**

```json
{
  "message": "Produk ditambahkan ke wishlist",
  "data": null
}
```

---

#### `DELETE /wishlist/:productId`

Removes a product from the server wishlist.

**Auth required:** ✅

**Path Parameters:**

| Parameter   | Type     | Description          |
| ----------- | -------- | -------------------- |
| `productId` | `string` | Product ID to remove |

**Response `200`:**

```json
{
  "message": "Produk dihapus dari wishlist",
  "data": null
}
```

---

## Appendix A: Order Status Flow

```
menunggu_pembayaran  →  diproses  →  dikirim  →  selesai
         ↓
    dibatalkan
```

| Status                | Description                          | Notes                                          |
| --------------------- | ------------------------------------ | ---------------------------------------------- |
| `menunggu_pembayaran` | Awaiting payment                     | `payment_info` (VA number/expiry) is present   |
| `diproses`            | Payment confirmed; seller is packing | `payment_info` becomes null                    |
| `dikirim`             | Handed to courier                    | `tracking_number` is populated                 |
| `selesai`             | Buyer confirmed receipt              | Final state                                    |
| `dibatalkan`          | Order cancelled                      | Can only transition from `menunggu_pembayaran` |

---

## Appendix B: Notification Types

| `type`         | Icon (app)                | Use case                                          |
| -------------- | ------------------------- | ------------------------------------------------- |
| `promo`        | 🏷️ `local_offer_rounded`  | Flash sales, new collections, promo codes         |
| `order_update` | 🧾 `receipt_long_rounded` | Order status changes, shipping updates            |
| `system`       | ℹ️ `info_rounded`         | App announcements, policy updates, account alerts |

---

## Appendix C: Size Format Conventions

| Category    | Size Format          | Examples                                 |
| ----------- | -------------------- | ---------------------------------------- |
| Clothing    | Standard letter      | `XS`, `S`, `M`, `L`, `XL`, `XXL`         |
| Shoes       | Indonesian EU sizing | `36`, `37`, `38`, `39`, `40`, `41`, `42` |
| Accessories | Fixed / measurement  | `ONE SIZE`, `40cm`, `45cm`, `50cm`       |

---

## Appendix D: Currency

- All monetary values are returned as **floating-point numbers** (IDR)
- Display format: `Rp xxx.xxx` (Indonesian locale, zero decimal digits)
- Example: API returns `189000.0` → display as `Rp 189.000`
- The app uses `NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0)`

---

## Appendix E: JSON Field Mapping (Flutter ↔ API)

The Flutter app uses `@JsonKey` annotations to map snake_case API fields to camelCase Dart fields. The backend must use the API key names in the left column.

| API JSON Key         | Flutter Field      | Model(s)                                  |
| -------------------- | ------------------ | ----------------------------------------- |
| `discount_price`     | `discountPrice`    | Product, CartItem, WishlistProduct        |
| `reviews_count`      | `reviewCount`      | Product                                   |
| `has_ai_try_on`      | `hasAiTryOn`       | Product                                   |
| `is_featured`        | `isFeatured`       | Product                                   |
| `additional_price`   | `additionalPrice`  | ProductVariant                            |
| `avatar_url`         | `avatarUrl`        | User                                      |
| `style_preferences`  | `stylePreferences` | User                                      |
| `product_id`         | `productId`        | CartItem, CartItemRef, OrderItem          |
| `product_name`       | `productName`      | CartItem, CartItemRef, OrderItem          |
| `product_image`      | `productImage`     | CartItem, CartItemRef, OrderItem          |
| `receiver_name`      | `receiverName`     | ShippingAddress, OrderDetail              |
| `is_default`         | `isDefault`        | ShippingAddress                           |
| `postal_code`        | `postalCode`       | ShippingAddress                           |
| `estimated_days`     | `estimatedDays`    | ShippingOption                            |
| `order_number`       | `orderNumber`      | OrderSummary, OrderDetail, PlacedOrder    |
| `item_count`         | `itemCount`        | OrderSummary                              |
| `first_item_image`   | `firstItemImage`   | OrderSummary                              |
| `first_item_name`    | `firstItemName`    | OrderSummary                              |
| `shipping_cost`      | `shippingCost`     | PlacedOrder, OrderDetail                  |
| `payment_method`     | `paymentMethod`    | PlacedOrder, OrderDetail                  |
| `shipping_courier`   | `shippingCourier`  | OrderDetail                               |
| `shipping_service`   | `shippingService`  | OrderDetail                               |
| `tracking_number`    | `trackingNumber`   | OrderDetail                               |
| `created_at`         | `createdAt`        | All timestamped models                    |
| `is_selected`        | `isSelected`       | StylePreference                           |
| `preferred_size`     | `preferredSize`    | FitProfile                                |
| `user_id`            | `userId`           | FitProfile, Review                        |
| `user_name`          | `userName`         | Review                                    |
| `user_avatar`        | `userAvatar`       | Review                                    |
| `original_image_url` | `originalImageUrl` | TryOnResult                               |
| `result_image_url`   | `resultImageUrl`   | TryOnResult                               |
| `is_saved`           | `isSaved`          | TryOnResult                               |
| `is_read`            | `isRead`           | NotificationItem                          |
| `action_route`       | `actionRoute`      | NotificationItem                          |
| `image_url`          | `imageUrl`         | Banner, NotificationItem, WishlistProduct |
| `icon_url`           | `iconUrl`          | Category, PaymentMethod                   |
| `deep_link`          | `deepLink`         | Banner                                    |
