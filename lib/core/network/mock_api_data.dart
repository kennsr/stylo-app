import 'dart:math';
import '../constants/api_constants.dart';

class MockApiData {
  static final Random _random = Random();

  static Map<String, dynamic> getMockResponse(
    String path, {
    String method = 'GET',
  }) {
    // Auth Routes
    if (path == ApiConstants.login ||
        path == ApiConstants.register ||
        path == ApiConstants.me) {
      return {
        'message': 'Success',
        'data': {
          'id': 'mock_user_123',
          'email': 'test@stylo.id',
          'name': 'Test Account',
          'avatar_url': 'https://i.pravatar.cc/150?u=123',
          'style_preferences': ['Casual', 'Streetwear'],
          'token': 'mock_jwt_token_12345',
        },
      };
    }

    // Home Banners
    if (path == '/home/banners') {
      return {
        'message': 'Success',
        'data': [
          {
            'id': 'banner_1',
            'image_url': 'https://picsum.photos/seed/promo1/800/400',
            'title': 'Promo Spesial',
            'subtitle': 'Diskon hingga 50%',
            'deep_link': '/promo/1',
          },
          {
            'id': 'banner_2',
            'image_url': 'https://picsum.photos/seed/promo2/800/400',
            'title': 'Koleksi Terbaru',
            'subtitle': 'Musim Panas',
            'deep_link': '/promo/2',
          },
        ],
      };
    }

    // Products
    if (path == ApiConstants.products) {
      return {
        'message': 'Success',
        'data': List.generate(10, (index) => _generateProduct(index)),
      };
    }

    if (path == ApiConstants.categories) {
      return {
        'message': 'Success',
        'data': [
          {
            'id': 'cat1',
            'name': 'Pakaian Pria',
            'icon_url': 'https://picsum.photos/seed/cat1/50',
          },
          {
            'id': 'cat2',
            'name': 'Pakaian Wanita',
            'icon_url': 'https://picsum.photos/seed/cat2/50',
          },
          {
            'id': 'cat3',
            'name': 'Aksesoris',
            'icon_url': 'https://picsum.photos/seed/cat3/50',
          },
        ],
      };
    }

    // Try-On
    if (path == ApiConstants.tryOn) {
      return {
        'message': 'Try-on task generated',
        'data': {
          'task_id': 'mock_task_id_${_random.nextInt(1000)}',
          'status': 'processing',
        },
      };
    }

    // Cart & Checkout
    if (path == ApiConstants.cart) {
      if (method == 'GET') {
        return {
          'message': 'Success',
          'data': {
            'items': [
              {
                'id': 'cart_item_1',
                'product_id': 'prod_0',
                'product_name': 'Mock Product 0',
                'product_image': 'https://picsum.photos/seed/0/400/400',
                'price': 150000.0,
                'quantity': 1,
                'size': 'M',
                'color': 'Black',
              },
            ],
            'subtotal': 150000,
            'total': 150000,
          },
        };
      } else {
        return {'message': 'Success'};
      }
    }

    if (path == ApiConstants.checkoutAddresses) {
      return {
        'message': 'Success',
        'data': [
          {
            'id': 'addr_1',
            'label': 'Rumah',
            'recipient_name': 'Test Account',
            'phone_number': '081234567890',
            'full_address': 'Jl. Mock Address No. 123',
            'city': 'Jakarta Selatan',
            'province': 'DKI Jakarta',
            'postal_code': '12345',
            'is_default': true,
          },
        ],
      };
    }

    if (path == ApiConstants.checkoutShipping) {
      return {
        'message': 'Success',
        'data': [
          {
            'id': 'ship_1',
            'name': 'Reguler',
            'price': 15000,
            'estimated_days': '2-3 Hari',
          },
          {
            'id': 'ship_2',
            'name': 'Express',
            'price': 25000,
            'estimated_days': '1 Hari',
          },
        ],
      };
    }

    if (path == ApiConstants.checkoutPayments) {
      return {
        'message': 'Success',
        'data': [
          {
            'id': 'pay_1',
            'name': 'GoPay',
            'type': 'ewallet',
            'icon_url': 'https://picsum.photos/seed/gopay/50',
          },
          {
            'id': 'pay_2',
            'name': 'BCA Virtual Account',
            'type': 'virtual_account',
            'icon_url': 'https://picsum.photos/seed/bca/50',
          },
        ],
      };
    }

    if (path == ApiConstants.checkoutPlaceOrder) {
      return {
        'message': 'Order placed successfully',
        'data': {
          'id': 'ord_${_random.nextInt(10000)}',
          'status': 'pending_payment',
          'total_amount': 165000,
          'payment_info': {
            'virtual_account_number': '1234567890123456',
            'expires_at': DateTime.now()
                .add(Duration(hours: 24))
                .toIso8601String(),
          },
        },
      };
    }

    // Orders
    if (path == ApiConstants.orders) {
      return {
        'message': 'Success',
        'data': [
          {
            'id': 'ord_001',
            'order_number': 'ORD-20231015-001',
            'item_count': 1,
            'total': 250000.0,
            'status': 'completed',
            'created_at': DateTime.now()
                .subtract(const Duration(days: 2))
                .toIso8601String(),
            'first_item_name': 'Mock T-Shirt',
            'first_item_image': 'https://picsum.photos/seed/order1/150',
          },
        ],
      };
    }

    if (path.startsWith('${ApiConstants.orders}/')) {
      final orderId = path.split('/').last;
      return {
        'message': 'Success',
        'data': {
          'id': orderId,
          'order_number': 'ORD-20231015-001',
          'status': 'completed',
          'subtotal': 250000.0,
          'shipping_cost': 15000.0,
          'total': 265000.0,
          'payment_method': 'GoPay',
          'shipping_courier': 'JNE',
          'shipping_service': 'Reguler',
          'receiver_name': 'Test Account',
          'address': 'Jl. Mock Address No. 123',
          'phone': '081234567890',
          'created_at': DateTime.now()
              .subtract(const Duration(days: 2))
              .toIso8601String(),
          'items': [
            {
              'product_id': 'prod_1',
              'product_name': 'Mock T-Shirt',
              'quantity': 1,
              'price': 250000.0,
              'size': 'M',
              'color': 'Black',
              'product_image': 'https://picsum.photos/seed/order1/150',
            },
          ],
        },
      };
    }

    // Profile
    if (path == ApiConstants.profile) {
      return {
        'message': 'Success',
        'data': {
          'id': 'mock_user_123',
          'email': 'test@stylo.id',
          'name': 'Test Account',
          'phone': '081234567890',
          'avatar_url': 'https://i.pravatar.cc/150?u=123',
          'style_preferences': ['Casual', 'Streetwear'],
          'token': 'mock_jwt_token_12345',
        },
      };
    }

    if (path == '${ApiConstants.profile}/style-preferences') {
      return {
        'message': 'Success',
        'data': [
          {'id': 'style_1', 'name': 'Casual', 'is_selected': true},
          {'id': 'style_2', 'name': 'Streetwear', 'is_selected': true},
          {'id': 'style_3', 'name': 'Formal', 'is_selected': false},
          {'id': 'style_4', 'name': 'Vintage', 'is_selected': false},
          {'id': 'style_5', 'name': 'Sporty', 'is_selected': false},
        ],
      };
    }

    // Default fallback
    return {'message': 'Mock Route Not Defined Fully', 'data': []};
  }

  static Map<String, dynamic> _generateProduct(int index) {
    return {
      'id': 'prod_$index',
      'name': 'Mock Product $index',
      'description':
          'This is an awesome mock product description for product $index.',
      'price': 150000.0 + (index * 10000),
      'image_url': 'https://picsum.photos/seed/$index/400/400',
      'category': 'Pakaian Pria',
      'rating': 4.5,
      'has_ai_try_on': index % 2 == 0,
      'reviews_count': 120 + index,
      'variants': [
        {
          'id': 'var_${index}_1',
          'name': 'S - Black',
          'price': 150000.0,
          'stock': 10,
        },
        {
          'id': 'var_${index}_2',
          'name': 'M - Black',
          'price': 150000.0,
          'stock': 15,
        },
      ],
    };
  }
}
