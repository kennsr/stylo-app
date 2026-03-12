import 'dart:math';
import '../constants/api_constants.dart';

class MockApiData {
  static final Random _random = Random();

  // ---------------------------------------------------------------------------
  // Static product catalogue – 20 realistic Indonesian fashion items
  // ---------------------------------------------------------------------------
  static const List<Map<String, dynamic>> _products = [
    // 0 – Kemeja Oxford Slim Fit (Pakaian Pria)
    {
      'id': 'prod_0',
      'name': 'Kemeja Oxford Slim Fit',
      'description':
          'Kemeja Oxford premium dengan potongan slim fit yang modern dan elegan. '
          'Dibuat dari bahan katun Oxford berkualitas tinggi yang nyaman dipakai sepanjang hari. '
          'Cocok untuk tampilan kasual sehari-hari maupun acara semi-formal.',
      'price': 189000.0,
      'discount_price': null,
      'image_url': 'https://picsum.photos/seed/kemeja_oxford/400/400',
      'category': 'Pakaian Pria',
      'rating': 4.7,
      'reviews_count': 312,
      'has_ai_try_on': true,
      'stock': 45,
      'is_featured': true,
      'variants': [
        {
          'id': 'var_0_1',
          'size': 'S',
          'color': 'Putih',
          'price': 189000.0,
          'stock': 8,
        },
        {
          'id': 'var_0_2',
          'size': 'M',
          'color': 'Putih',
          'price': 189000.0,
          'stock': 12,
        },
        {
          'id': 'var_0_3',
          'size': 'L',
          'color': 'Putih',
          'price': 189000.0,
          'stock': 10,
        },
        {
          'id': 'var_0_4',
          'size': 'XL',
          'color': 'Putih',
          'price': 189000.0,
          'stock': 5,
        },
        {
          'id': 'var_0_5',
          'size': 'S',
          'color': 'Hitam',
          'price': 189000.0,
          'stock': 6,
        },
        {
          'id': 'var_0_6',
          'size': 'M',
          'color': 'Hitam',
          'price': 189000.0,
          'stock': 9,
        },
        {
          'id': 'var_0_7',
          'size': 'L',
          'color': 'Hitam',
          'price': 189000.0,
          'stock': 7,
        },
        {
          'id': 'var_0_8',
          'size': 'M',
          'color': 'Navy',
          'price': 189000.0,
          'stock': 11,
        },
        {
          'id': 'var_0_9',
          'size': 'L',
          'color': 'Navy',
          'price': 189000.0,
          'stock': 8,
        },
      ],
    },
    // 1 – Kaos Oversize Streetwear (Pakaian Pria)
    {
      'id': 'prod_1',
      'name': 'Kaos Oversize Streetwear',
      'description':
          'Kaos oversize dengan desain streetwear yang kekinian dan trendi. '
          'Material cotton combed 30s yang lembut dan breathable sangat cocok untuk aktivitas harian. '
          'Hadir dalam berbagai pilihan warna yang bisa dipadukan dengan berbagai outfit.',
      'price': 129000.0,
      'discount_price': null,
      'image_url': 'https://picsum.photos/seed/kaos_oversize/400/400',
      'category': 'Pakaian Pria',
      'rating': 4.5,
      'reviews_count': 487,
      'has_ai_try_on': true,
      'stock': 80,
      'is_featured': true,
      'variants': [
        {
          'id': 'var_1_1',
          'size': 'M',
          'color': 'Hitam',
          'price': 129000.0,
          'stock': 20,
        },
        {
          'id': 'var_1_2',
          'size': 'L',
          'color': 'Hitam',
          'price': 129000.0,
          'stock': 18,
        },
        {
          'id': 'var_1_3',
          'size': 'XL',
          'color': 'Hitam',
          'price': 129000.0,
          'stock': 15,
        },
        {
          'id': 'var_1_4',
          'size': 'XXL',
          'color': 'Hitam',
          'price': 129000.0,
          'stock': 10,
        },
        {
          'id': 'var_1_5',
          'size': 'M',
          'color': 'Putih',
          'price': 129000.0,
          'stock': 17,
        },
        {
          'id': 'var_1_6',
          'size': 'L',
          'color': 'Putih',
          'price': 129000.0,
          'stock': 14,
        },
        {
          'id': 'var_1_7',
          'size': 'M',
          'color': 'Abu-abu',
          'price': 129000.0,
          'stock': 12,
        },
        {
          'id': 'var_1_8',
          'size': 'L',
          'color': 'Abu-abu',
          'price': 129000.0,
          'stock': 9,
        },
      ],
    },
    // 2 – Celana Chino Premium (Pakaian Pria)
    {
      'id': 'prod_2',
      'name': 'Celana Chino Premium',
      'description':
          'Celana chino dengan bahan premium yang nyaman dan tahan lama. '
          'Potongan slim fit memberikan tampilan rapi dan profesional untuk berbagai kesempatan. '
          'Tersedia dalam pilihan warna netral yang mudah dipadukan dengan berbagai atasan.',
      'price': 259000.0,
      'discount_price': null,
      'image_url': 'https://picsum.photos/seed/celana_chino/400/400',
      'category': 'Pakaian Pria',
      'rating': 4.6,
      'reviews_count': 198,
      'has_ai_try_on': false,
      'stock': 35,
      'is_featured': false,
      'variants': [
        {
          'id': 'var_2_1',
          'size': 'S',
          'color': 'Krem',
          'price': 259000.0,
          'stock': 5,
        },
        {
          'id': 'var_2_2',
          'size': 'M',
          'color': 'Krem',
          'price': 259000.0,
          'stock': 8,
        },
        {
          'id': 'var_2_3',
          'size': 'L',
          'color': 'Krem',
          'price': 259000.0,
          'stock': 6,
        },
        {
          'id': 'var_2_4',
          'size': 'XL',
          'color': 'Krem',
          'price': 259000.0,
          'stock': 4,
        },
        {
          'id': 'var_2_5',
          'size': 'M',
          'color': 'Navy',
          'price': 259000.0,
          'stock': 7,
        },
        {
          'id': 'var_2_6',
          'size': 'L',
          'color': 'Navy',
          'price': 259000.0,
          'stock': 5,
        },
        {
          'id': 'var_2_7',
          'size': 'M',
          'color': 'Hitam',
          'price': 259000.0,
          'stock': 9,
        },
        {
          'id': 'var_2_8',
          'size': 'L',
          'color': 'Hitam',
          'price': 259000.0,
          'stock': 6,
        },
      ],
    },
    // 3 – Jaket Denim Vintage (Outerwear) – with discount
    {
      'id': 'prod_3',
      'name': 'Jaket Denim Vintage',
      'description':
          'Jaket denim dengan tampilan vintage yang klasik namun tetap stylish. '
          'Bahan denim tebal berkualitas tinggi memberikan perlindungan optimal dan tampilan yang bold. '
          'Washed finish memberikan kesan casual dan edgy yang sempurna untuk gaya streetwear.',
      'price': 449000.0,
      'discount_price': 349000.0,
      'image_url': 'https://picsum.photos/seed/jaket_denim/400/400',
      'category': 'Outerwear',
      'rating': 4.8,
      'reviews_count': 256,
      'has_ai_try_on': true,
      'stock': 28,
      'is_featured': true,
      'variants': [
        {
          'id': 'var_3_1',
          'size': 'S',
          'color': 'Navy',
          'price': 449000.0,
          'stock': 4,
        },
        {
          'id': 'var_3_2',
          'size': 'M',
          'color': 'Navy',
          'price': 449000.0,
          'stock': 7,
        },
        {
          'id': 'var_3_3',
          'size': 'L',
          'color': 'Navy',
          'price': 449000.0,
          'stock': 6,
        },
        {
          'id': 'var_3_4',
          'size': 'XL',
          'color': 'Navy',
          'price': 449000.0,
          'stock': 5,
        },
        {
          'id': 'var_3_5',
          'size': 'M',
          'color': 'Hitam',
          'price': 449000.0,
          'stock': 6,
        },
        {
          'id': 'var_3_6',
          'size': 'L',
          'color': 'Hitam',
          'price': 449000.0,
          'stock': 4,
        },
      ],
    },
    // 4 – Hoodie Fleece Tebal (Outerwear)
    {
      'id': 'prod_4',
      'name': 'Hoodie Fleece Tebal',
      'description':
          'Hoodie dengan bahan fleece premium yang tebal dan hangat, ideal untuk cuaca dingin. '
          'Desain kangaroo pocket dan tali hoodie yang adjustable menambah kesan sporty dan fungsional. '
          'Jahitan rapi dan bahan anti-pilling memastikan produk tahan lama dan tetap nyaman.',
      'price': 329000.0,
      'discount_price': null,
      'image_url': 'https://picsum.photos/seed/hoodie_fleece/400/400',
      'category': 'Outerwear',
      'rating': 4.7,
      'reviews_count': 334,
      'has_ai_try_on': true,
      'stock': 52,
      'is_featured': true,
      'variants': [
        {
          'id': 'var_4_1',
          'size': 'S',
          'color': 'Abu-abu',
          'price': 329000.0,
          'stock': 8,
        },
        {
          'id': 'var_4_2',
          'size': 'M',
          'color': 'Abu-abu',
          'price': 329000.0,
          'stock': 12,
        },
        {
          'id': 'var_4_3',
          'size': 'L',
          'color': 'Abu-abu',
          'price': 329000.0,
          'stock': 10,
        },
        {
          'id': 'var_4_4',
          'size': 'XL',
          'color': 'Abu-abu',
          'price': 329000.0,
          'stock': 7,
        },
        {
          'id': 'var_4_5',
          'size': 'M',
          'color': 'Hitam',
          'price': 329000.0,
          'stock': 9,
        },
        {
          'id': 'var_4_6',
          'size': 'L',
          'color': 'Hitam',
          'price': 329000.0,
          'stock': 8,
        },
        {
          'id': 'var_4_7',
          'size': 'M',
          'color': 'Navy',
          'price': 329000.0,
          'stock': 6,
        },
        {
          'id': 'var_4_8',
          'size': 'L',
          'color': 'Navy',
          'price': 329000.0,
          'stock': 5,
        },
        {
          'id': 'var_4_9',
          'size': 'L',
          'color': 'Hijau Sage',
          'price': 329000.0,
          'stock': 4,
        },
      ],
    },
    // 5 – Blazer Casual Wanita (Pakaian Wanita)
    {
      'id': 'prod_5',
      'name': 'Blazer Casual Wanita',
      'description':
          'Blazer kasual wanita dengan potongan modern yang bisa dipadupadankan untuk berbagai kesempatan. '
          'Bahan tweed premium dengan tekstur halus memberikan kesan profesional namun tetap stylish. '
          'Cocok untuk meeting di kantor, date night, maupun acara semi-formal lainnya.',
      'price': 399000.0,
      'discount_price': null,
      'image_url': 'https://picsum.photos/seed/blazer_wanita/400/400',
      'category': 'Pakaian Wanita',
      'rating': 4.9,
      'reviews_count': 145,
      'has_ai_try_on': true,
      'stock': 30,
      'is_featured': true,
      'variants': [
        {
          'id': 'var_5_1',
          'size': 'XS',
          'color': 'Hitam',
          'price': 399000.0,
          'stock': 5,
        },
        {
          'id': 'var_5_2',
          'size': 'S',
          'color': 'Hitam',
          'price': 399000.0,
          'stock': 7,
        },
        {
          'id': 'var_5_3',
          'size': 'M',
          'color': 'Hitam',
          'price': 399000.0,
          'stock': 8,
        },
        {
          'id': 'var_5_4',
          'size': 'L',
          'color': 'Hitam',
          'price': 399000.0,
          'stock': 5,
        },
        {
          'id': 'var_5_5',
          'size': 'XS',
          'color': 'Krem',
          'price': 399000.0,
          'stock': 4,
        },
        {
          'id': 'var_5_6',
          'size': 'S',
          'color': 'Krem',
          'price': 399000.0,
          'stock': 6,
        },
        {
          'id': 'var_5_7',
          'size': 'M',
          'color': 'Krem',
          'price': 399000.0,
          'stock': 5,
        },
      ],
    },
    // 6 – Blouse Floral Chiffon (Pakaian Wanita) – with discount
    {
      'id': 'prod_6',
      'name': 'Blouse Floral Chiffon',
      'description':
          'Blouse chiffon ringan dengan motif floral yang feminin dan elegan. '
          'Bahan chiffon premium yang jatuh dengan indah dan nyaman dipakai sepanjang hari. '
          'Desain lengan balon menambah kesan romantis dan cocok untuk berbagai kesempatan.',
      'price': 169000.0,
      'discount_price': 129000.0,
      'image_url': 'https://picsum.photos/seed/blouse_floral/400/400',
      'category': 'Pakaian Wanita',
      'rating': 4.6,
      'reviews_count': 221,
      'has_ai_try_on': false,
      'stock': 60,
      'is_featured': false,
      'variants': [
        {
          'id': 'var_6_1',
          'size': 'XS',
          'color': 'Putih',
          'price': 169000.0,
          'stock': 10,
        },
        {
          'id': 'var_6_2',
          'size': 'S',
          'color': 'Putih',
          'price': 169000.0,
          'stock': 14,
        },
        {
          'id': 'var_6_3',
          'size': 'M',
          'color': 'Putih',
          'price': 169000.0,
          'stock': 12,
        },
        {
          'id': 'var_6_4',
          'size': 'L',
          'color': 'Putih',
          'price': 169000.0,
          'stock': 8,
        },
        {
          'id': 'var_6_5',
          'size': 'S',
          'color': 'Merah',
          'price': 169000.0,
          'stock': 9,
        },
        {
          'id': 'var_6_6',
          'size': 'M',
          'color': 'Merah',
          'price': 169000.0,
          'stock': 7,
        },
      ],
    },
    // 7 – Dress Midi Elegant (Dress)
    {
      'id': 'prod_7',
      'name': 'Dress Midi Elegant',
      'description':
          'Dress midi dengan siluet A-line yang elegan dan feminin untuk berbagai kesempatan spesial. '
          'Material satin premium memberikan kilap lembut dan jatuhnya kain yang indah di tubuh. '
          'Detail ruffle di bagian bawah menambah kesan mewah dan romantis.',
      'price': 299000.0,
      'discount_price': null,
      'image_url': 'https://picsum.photos/seed/dress_midi/400/400',
      'category': 'Dress',
      'rating': 4.8,
      'reviews_count': 178,
      'has_ai_try_on': true,
      'stock': 25,
      'is_featured': false,
      'variants': [
        {
          'id': 'var_7_1',
          'size': 'XS',
          'color': 'Hitam',
          'price': 299000.0,
          'stock': 5,
        },
        {
          'id': 'var_7_2',
          'size': 'S',
          'color': 'Hitam',
          'price': 299000.0,
          'stock': 6,
        },
        {
          'id': 'var_7_3',
          'size': 'M',
          'color': 'Hitam',
          'price': 299000.0,
          'stock': 7,
        },
        {
          'id': 'var_7_4',
          'size': 'L',
          'color': 'Hitam',
          'price': 299000.0,
          'stock': 4,
        },
        {
          'id': 'var_7_5',
          'size': 'S',
          'color': 'Merah',
          'price': 299000.0,
          'stock': 5,
        },
        {
          'id': 'var_7_6',
          'size': 'M',
          'color': 'Merah',
          'price': 299000.0,
          'stock': 6,
        },
      ],
    },
    // 8 – Mini Dress Floral (Dress) – with discount
    {
      'id': 'prod_8',
      'name': 'Mini Dress Floral',
      'description':
          'Mini dress dengan motif floral yang cerah dan ceria, cocok untuk berbagai suasana. '
          'Bahan jersey stretch yang nyaman dan mengikuti lekuk tubuh dengan sempurna. '
          'Desain tali spaghetti dan detail shirring di bagian tubuh menambah kesan sweet dan girly.',
      'price': 219000.0,
      'discount_price': 179000.0,
      'image_url': 'https://picsum.photos/seed/mini_dress_floral/400/400',
      'category': 'Dress',
      'rating': 4.5,
      'reviews_count': 302,
      'has_ai_try_on': true,
      'stock': 40,
      'is_featured': false,
      'variants': [
        {
          'id': 'var_8_1',
          'size': 'XS',
          'color': 'Putih',
          'price': 219000.0,
          'stock': 8,
        },
        {
          'id': 'var_8_2',
          'size': 'S',
          'color': 'Putih',
          'price': 219000.0,
          'stock': 10,
        },
        {
          'id': 'var_8_3',
          'size': 'M',
          'color': 'Putih',
          'price': 219000.0,
          'stock': 9,
        },
        {
          'id': 'var_8_4',
          'size': 'L',
          'color': 'Putih',
          'price': 219000.0,
          'stock': 6,
        },
        {
          'id': 'var_8_5',
          'size': 'S',
          'color': 'Merah',
          'price': 219000.0,
          'stock': 7,
        },
        {
          'id': 'var_8_6',
          'size': 'M',
          'color': 'Merah',
          'price': 219000.0,
          'stock': 5,
        },
      ],
    },
    // 9 – Maxi Dress Boho (Dress)
    {
      'id': 'prod_9',
      'name': 'Maxi Dress Boho',
      'description':
          'Maxi dress dengan gaya boho-chic yang memancarkan aura bohemian yang bebas dan artistik. '
          'Bahan rayon premium yang ringan dan breathable sangat nyaman untuk aktivitas outdoor. '
          'Motif etnik dan detail tassel di ujung dress memberikan sentuhan bohemian yang autentik.',
      'price': 349000.0,
      'discount_price': null,
      'image_url': 'https://picsum.photos/seed/maxi_dress_boho/400/400',
      'category': 'Dress',
      'rating': 4.7,
      'reviews_count': 134,
      'has_ai_try_on': false,
      'stock': 22,
      'is_featured': false,
      'variants': [
        {
          'id': 'var_9_1',
          'size': 'XS',
          'color': 'Krem',
          'price': 349000.0,
          'stock': 5,
        },
        {
          'id': 'var_9_2',
          'size': 'S',
          'color': 'Krem',
          'price': 349000.0,
          'stock': 6,
        },
        {
          'id': 'var_9_3',
          'size': 'M',
          'color': 'Krem',
          'price': 349000.0,
          'stock': 5,
        },
        {
          'id': 'var_9_4',
          'size': 'L',
          'color': 'Krem',
          'price': 349000.0,
          'stock': 4,
        },
        {
          'id': 'var_9_5',
          'size': 'S',
          'color': 'Hijau Sage',
          'price': 349000.0,
          'stock': 3,
        },
        {
          'id': 'var_9_6',
          'size': 'M',
          'color': 'Hijau Sage',
          'price': 349000.0,
          'stock': 3,
        },
      ],
    },
    // 10 – Tote Bag Canvas (Aksesoris)
    {
      'id': 'prod_10',
      'name': 'Tote Bag Canvas',
      'description':
          'Tote bag canvas yang fungsional dan stylish untuk menemani aktivitas sehari-hari. '
          'Material canvas tebal dan jahitan kuat mampu menampung banyak barang dengan aman. '
          'Desain minimalis dengan print quotes inspiratif cocok untuk tampilan kasual dan trendi.',
      'price': 89000.0,
      'discount_price': null,
      'image_url': 'https://picsum.photos/seed/tote_bag/400/400',
      'category': 'Aksesoris',
      'rating': 4.4,
      'reviews_count': 489,
      'has_ai_try_on': false,
      'stock': 100,
      'is_featured': false,
      'variants': [
        {
          'id': 'var_10_1',
          'size': 'ONE SIZE',
          'color': 'Putih',
          'price': 89000.0,
          'stock': 30,
        },
        {
          'id': 'var_10_2',
          'size': 'ONE SIZE',
          'color': 'Hitam',
          'price': 89000.0,
          'stock': 25,
        },
        {
          'id': 'var_10_3',
          'size': 'ONE SIZE',
          'color': 'Krem',
          'price': 89000.0,
          'stock': 20,
        },
        {
          'id': 'var_10_4',
          'size': 'ONE SIZE',
          'color': 'Navy',
          'price': 89000.0,
          'stock': 15,
        },
        {
          'id': 'var_10_5',
          'size': 'ONE SIZE',
          'color': 'Hijau Sage',
          'price': 89000.0,
          'stock': 10,
        },
      ],
    },
    // 11 – Topi Bucket Hat (Aksesoris) – with discount
    {
      'id': 'prod_11',
      'name': 'Topi Bucket Hat',
      'description':
          'Bucket hat trendi yang menjadi statement piece untuk outfit kasual dan streetwear. '
          'Material canvas premium dengan jahitan topi yang kokoh dan tahan lama. '
          'Tersedia dalam berbagai pilihan warna cerah dan netral untuk melengkapi berbagai gaya.',
      'price': 99000.0,
      'discount_price': 79000.0,
      'image_url': 'https://picsum.photos/seed/bucket_hat/400/400',
      'category': 'Aksesoris',
      'rating': 4.3,
      'reviews_count': 267,
      'has_ai_try_on': false,
      'stock': 75,
      'is_featured': false,
      'variants': [
        {
          'id': 'var_11_1',
          'size': 'ONE SIZE',
          'color': 'Hitam',
          'price': 99000.0,
          'stock': 20,
        },
        {
          'id': 'var_11_2',
          'size': 'ONE SIZE',
          'color': 'Putih',
          'price': 99000.0,
          'stock': 18,
        },
        {
          'id': 'var_11_3',
          'size': 'ONE SIZE',
          'color': 'Navy',
          'price': 99000.0,
          'stock': 15,
        },
        {
          'id': 'var_11_4',
          'size': 'ONE SIZE',
          'color': 'Krem',
          'price': 99000.0,
          'stock': 12,
        },
        {
          'id': 'var_11_5',
          'size': 'ONE SIZE',
          'color': 'Hijau Sage',
          'price': 99000.0,
          'stock': 10,
        },
      ],
    },
    // 12 – Sneakers Putih Classic (Sepatu)
    {
      'id': 'prod_12',
      'name': 'Sneakers Putih Classic',
      'description':
          'Sneakers putih klasik yang timeless dan cocok dipadukan dengan hampir semua outfit. '
          'Sol karet EVA yang ringan dan nyaman memastikan kenyamanan sepanjang hari. '
          'Upper berbahan kanvas premium dengan sol anti-slip yang aman untuk berbagai permukaan.',
      'price': 499000.0,
      'discount_price': null,
      'image_url': 'https://picsum.photos/seed/sneakers_putih/400/400',
      'category': 'Sepatu',
      'rating': 4.8,
      'reviews_count': 415,
      'has_ai_try_on': false,
      'stock': 55,
      'is_featured': false,
      'variants': [
        {
          'id': 'var_12_1',
          'size': '37',
          'color': 'Putih',
          'price': 499000.0,
          'stock': 8,
        },
        {
          'id': 'var_12_2',
          'size': '38',
          'color': 'Putih',
          'price': 499000.0,
          'stock': 10,
        },
        {
          'id': 'var_12_3',
          'size': '39',
          'color': 'Putih',
          'price': 499000.0,
          'stock': 12,
        },
        {
          'id': 'var_12_4',
          'size': '40',
          'color': 'Putih',
          'price': 499000.0,
          'stock': 11,
        },
        {
          'id': 'var_12_5',
          'size': '41',
          'color': 'Putih',
          'price': 499000.0,
          'stock': 9,
        },
        {
          'id': 'var_12_6',
          'size': '42',
          'color': 'Putih',
          'price': 499000.0,
          'stock': 5,
        },
        {
          'id': 'var_12_7',
          'size': '39',
          'color': 'Hitam',
          'price': 499000.0,
          'stock': 7,
        },
        {
          'id': 'var_12_8',
          'size': '40',
          'color': 'Hitam',
          'price': 499000.0,
          'stock': 6,
        },
        {
          'id': 'var_12_9',
          'size': '41',
          'color': 'Hitam',
          'price': 499000.0,
          'stock': 5,
        },
      ],
    },
    // 13 – Sepatu Loafers Pria (Sepatu) – with discount
    {
      'id': 'prod_13',
      'name': 'Sepatu Loafers Pria',
      'description':
          'Sepatu loafers pria yang menghadirkan perpaduan sempurna antara kenyamanan dan gaya. '
          'Bahan kulit PU premium dengan sol cushion yang memberikan kenyamanan optimal sepanjang hari. '
          'Desain slip-on yang praktis memudahkan pemakaian untuk berbagai kesempatan kasual hingga formal.',
      'price': 389000.0,
      'discount_price': 319000.0,
      'image_url': 'https://picsum.photos/seed/loafers_pria/400/400',
      'category': 'Sepatu',
      'rating': 4.6,
      'reviews_count': 183,
      'has_ai_try_on': false,
      'stock': 38,
      'is_featured': false,
      'variants': [
        {
          'id': 'var_13_1',
          'size': '39',
          'color': 'Hitam',
          'price': 389000.0,
          'stock': 6,
        },
        {
          'id': 'var_13_2',
          'size': '40',
          'color': 'Hitam',
          'price': 389000.0,
          'stock': 8,
        },
        {
          'id': 'var_13_3',
          'size': '41',
          'color': 'Hitam',
          'price': 389000.0,
          'stock': 7,
        },
        {
          'id': 'var_13_4',
          'size': '42',
          'color': 'Hitam',
          'price': 389000.0,
          'stock': 5,
        },
        {
          'id': 'var_13_5',
          'size': '40',
          'color': 'Krem',
          'price': 389000.0,
          'stock': 6,
        },
        {
          'id': 'var_13_6',
          'size': '41',
          'color': 'Krem',
          'price': 389000.0,
          'stock': 4,
        },
        {
          'id': 'var_13_7',
          'size': '42',
          'color': 'Krem',
          'price': 389000.0,
          'stock': 3,
        },
      ],
    },
    // 14 – Sandal Wanita Boho (Sepatu)
    {
      'id': 'prod_14',
      'name': 'Sandal Wanita Boho',
      'description':
          'Sandal wanita dengan gaya bohemian yang cantik dan nyaman untuk berbagai aktivitas. '
          'Material strap kulit sintetik dengan aksen anyaman menambah kesan artsy dan unik. '
          'Sol flatform yang ringan memberikan sedikit tinggi tambahan tanpa mengorbankan kenyamanan.',
      'price': 149000.0,
      'discount_price': null,
      'image_url': 'https://picsum.photos/seed/sandal_boho/400/400',
      'category': 'Sepatu',
      'rating': 4.4,
      'reviews_count': 298,
      'has_ai_try_on': false,
      'stock': 48,
      'is_featured': false,
      'variants': [
        {
          'id': 'var_14_1',
          'size': '36',
          'color': 'Krem',
          'price': 149000.0,
          'stock': 8,
        },
        {
          'id': 'var_14_2',
          'size': '37',
          'color': 'Krem',
          'price': 149000.0,
          'stock': 10,
        },
        {
          'id': 'var_14_3',
          'size': '38',
          'color': 'Krem',
          'price': 149000.0,
          'stock': 9,
        },
        {
          'id': 'var_14_4',
          'size': '39',
          'color': 'Krem',
          'price': 149000.0,
          'stock': 7,
        },
        {
          'id': 'var_14_5',
          'size': '37',
          'color': 'Hitam',
          'price': 149000.0,
          'stock': 6,
        },
        {
          'id': 'var_14_6',
          'size': '38',
          'color': 'Hitam',
          'price': 149000.0,
          'stock': 5,
        },
        {
          'id': 'var_14_7',
          'size': '39',
          'color': 'Hitam',
          'price': 149000.0,
          'stock': 3,
        },
      ],
    },
    // 15 – Kemeja Batik Modern (Pakaian Pria)
    {
      'id': 'prod_15',
      'name': 'Kemeja Batik Modern',
      'description':
          'Kemeja batik kontemporer yang memadukan motif batik tradisional dengan potongan modern. '
          'Bahan katun premium yang breathable dan nyaman dipakai seharian tanpa rasa pengap. '
          'Motif batik Jogja kontemporer memberikan kesan budaya yang kaya namun tetap kekinian.',
      'price': 299000.0,
      'discount_price': null,
      'image_url': 'https://picsum.photos/seed/batik_modern/400/400',
      'category': 'Pakaian Pria',
      'rating': 4.7,
      'reviews_count': 221,
      'has_ai_try_on': true,
      'stock': 33,
      'is_featured': false,
      'variants': [
        {
          'id': 'var_15_1',
          'size': 'S',
          'color': 'Navy',
          'price': 299000.0,
          'stock': 6,
        },
        {
          'id': 'var_15_2',
          'size': 'M',
          'color': 'Navy',
          'price': 299000.0,
          'stock': 9,
        },
        {
          'id': 'var_15_3',
          'size': 'L',
          'color': 'Navy',
          'price': 299000.0,
          'stock': 8,
        },
        {
          'id': 'var_15_4',
          'size': 'XL',
          'color': 'Navy',
          'price': 299000.0,
          'stock': 5,
        },
        {
          'id': 'var_15_5',
          'size': 'M',
          'color': 'Hitam',
          'price': 299000.0,
          'stock': 7,
        },
        {
          'id': 'var_15_6',
          'size': 'L',
          'color': 'Hitam',
          'price': 299000.0,
          'stock': 6,
        },
      ],
    },
    // 16 – Crop Top Knit (Pakaian Wanita)
    {
      'id': 'prod_16',
      'name': 'Crop Top Knit',
      'description':
          'Crop top rajut dengan tekstur yang unik dan tampilan yang chic untuk gaya kasual sehari-hari. '
          'Material knit elastis yang nyaman dan mengikuti bentuk tubuh dengan sempurna. '
          'Bisa dipadukan dengan high-waist jeans, rok midi, atau celana kulot untuk berbagai tampilan.',
      'price': 159000.0,
      'discount_price': null,
      'image_url': 'https://picsum.photos/seed/crop_top_knit/400/400',
      'category': 'Pakaian Wanita',
      'rating': 4.5,
      'reviews_count': 376,
      'has_ai_try_on': false,
      'stock': 65,
      'is_featured': false,
      'variants': [
        {
          'id': 'var_16_1',
          'size': 'XS',
          'color': 'Krem',
          'price': 159000.0,
          'stock': 12,
        },
        {
          'id': 'var_16_2',
          'size': 'S',
          'color': 'Krem',
          'price': 159000.0,
          'stock': 15,
        },
        {
          'id': 'var_16_3',
          'size': 'M',
          'color': 'Krem',
          'price': 159000.0,
          'stock': 13,
        },
        {
          'id': 'var_16_4',
          'size': 'L',
          'color': 'Krem',
          'price': 159000.0,
          'stock': 8,
        },
        {
          'id': 'var_16_5',
          'size': 'S',
          'color': 'Hitam',
          'price': 159000.0,
          'stock': 9,
        },
        {
          'id': 'var_16_6',
          'size': 'M',
          'color': 'Hitam',
          'price': 159000.0,
          'stock': 8,
        },
        {
          'id': 'var_16_7',
          'size': 'S',
          'color': 'Abu-abu',
          'price': 159000.0,
          'stock': 6,
        },
        {
          'id': 'var_16_8',
          'size': 'M',
          'color': 'Abu-abu',
          'price': 159000.0,
          'stock': 5,
        },
      ],
    },
    // 17 – Jumpsuit Casual (Dress) – with discount
    {
      'id': 'prod_17',
      'name': 'Jumpsuit Casual',
      'description':
          'Jumpsuit kasual satu potong yang praktis dan stylish untuk berbagai kesempatan. '
          'Bahan linen premium yang ringan dan breathable sangat nyaman untuk cuaca tropis Indonesia. '
          'Dilengkapi tali pinggang untuk mengatur silhouette sesuai keinginan.',
      'price': 279000.0,
      'discount_price': 229000.0,
      'image_url': 'https://picsum.photos/seed/jumpsuit_casual/400/400',
      'category': 'Dress',
      'rating': 4.6,
      'reviews_count': 167,
      'has_ai_try_on': true,
      'stock': 27,
      'is_featured': false,
      'variants': [
        {
          'id': 'var_17_1',
          'size': 'XS',
          'color': 'Krem',
          'price': 279000.0,
          'stock': 5,
        },
        {
          'id': 'var_17_2',
          'size': 'S',
          'color': 'Krem',
          'price': 279000.0,
          'stock': 7,
        },
        {
          'id': 'var_17_3',
          'size': 'M',
          'color': 'Krem',
          'price': 279000.0,
          'stock': 6,
        },
        {
          'id': 'var_17_4',
          'size': 'L',
          'color': 'Krem',
          'price': 279000.0,
          'stock': 4,
        },
        {
          'id': 'var_17_5',
          'size': 'S',
          'color': 'Hijau Sage',
          'price': 279000.0,
          'stock': 4,
        },
        {
          'id': 'var_17_6',
          'size': 'M',
          'color': 'Hijau Sage',
          'price': 279000.0,
          'stock': 3,
        },
        {
          'id': 'var_17_7',
          'size': 'S',
          'color': 'Hitam',
          'price': 279000.0,
          'stock': 5,
        },
        {
          'id': 'var_17_8',
          'size': 'M',
          'color': 'Hitam',
          'price': 279000.0,
          'stock': 4,
        },
      ],
    },
    // 18 – Jaket Bomber Pria (Outerwear)
    {
      'id': 'prod_18',
      'name': 'Jaket Bomber Pria',
      'description':
          'Jaket bomber pria dengan desain yang bold dan maskulin untuk tampilan yang gagah dan stylish. '
          'Material nylon premium dengan lapisan fleece di dalam memberikan kehangatan optimal. '
          'Detail ribbed collar, cuffs, dan hem memberikan kesan sporty yang autentik.',
      'price': 549000.0,
      'discount_price': null,
      'image_url': 'https://picsum.photos/seed/bomber_pria/400/400',
      'category': 'Outerwear',
      'rating': 4.8,
      'reviews_count': 143,
      'has_ai_try_on': true,
      'stock': 20,
      'is_featured': false,
      'variants': [
        {
          'id': 'var_18_1',
          'size': 'S',
          'color': 'Hitam',
          'price': 549000.0,
          'stock': 4,
        },
        {
          'id': 'var_18_2',
          'size': 'M',
          'color': 'Hitam',
          'price': 549000.0,
          'stock': 6,
        },
        {
          'id': 'var_18_3',
          'size': 'L',
          'color': 'Hitam',
          'price': 549000.0,
          'stock': 5,
        },
        {
          'id': 'var_18_4',
          'size': 'XL',
          'color': 'Hitam',
          'price': 549000.0,
          'stock': 3,
        },
        {
          'id': 'var_18_5',
          'size': 'M',
          'color': 'Navy',
          'price': 549000.0,
          'stock': 5,
        },
        {
          'id': 'var_18_6',
          'size': 'L',
          'color': 'Navy',
          'price': 549000.0,
          'stock': 4,
        },
        {
          'id': 'var_18_7',
          'size': 'M',
          'color': 'Hijau Sage',
          'price': 549000.0,
          'stock': 3,
        },
      ],
    },
    // 19 – Kalung Emas Minimalis (Aksesoris)
    {
      'id': 'prod_19',
      'name': 'Kalung Emas Minimalis',
      'description':
          'Kalung emas minimalis dengan desain sederhana namun elegan untuk melengkapi berbagai outfit. '
          'Terbuat dari besi anti-karat dengan lapisan emas 18K yang tahan lama dan tidak mudah pudar. '
          'Tersedia dalam dua panjang pilihan untuk mengikuti tren layering atau dipakai sendiri.',
      'price': 139000.0,
      'discount_price': null,
      'image_url': 'https://picsum.photos/seed/kalung_emas/400/400',
      'category': 'Aksesoris',
      'rating': 4.5,
      'reviews_count': 389,
      'has_ai_try_on': false,
      'stock': 90,
      'is_featured': false,
      'variants': [
        {
          'id': 'var_19_1',
          'size': '40cm',
          'color': 'Krem',
          'price': 139000.0,
          'stock': 30,
        },
        {
          'id': 'var_19_2',
          'size': '45cm',
          'color': 'Krem',
          'price': 139000.0,
          'stock': 25,
        },
        {
          'id': 'var_19_3',
          'size': '50cm',
          'color': 'Krem',
          'price': 139000.0,
          'stock': 20,
        },
      ],
    },
  ];

  // ---------------------------------------------------------------------------
  // Static orders list
  // ---------------------------------------------------------------------------
  static List<Map<String, dynamic>> _buildOrders() {
    final now = DateTime.now();
    return [
      {
        'id': 'ord_001',
        'order_number': 'STY-2026031101',
        'item_count': 2,
        'total': 345000.0,
        'status': 'menunggu_pembayaran',
        'created_at': now.subtract(const Duration(hours: 1)).toIso8601String(),
        'first_item_name': 'Kemeja Oxford Slim Fit',
        'first_item_image': 'https://picsum.photos/seed/kemeja_oxford/400/400',
      },
      {
        'id': 'ord_002',
        'order_number': 'STY-2026030901',
        'item_count': 1,
        'total': 198000.0,
        'status': 'diproses',
        'created_at': now.subtract(const Duration(days: 2)).toIso8601String(),
        'first_item_name': 'Blouse Floral Chiffon',
        'first_item_image': 'https://picsum.photos/seed/blouse_floral/400/400',
      },
      {
        'id': 'ord_003',
        'order_number': 'STY-2026030701',
        'item_count': 3,
        'total': 567000.0,
        'status': 'dikirim',
        'created_at': now.subtract(const Duration(days: 4)).toIso8601String(),
        'first_item_name': 'Hoodie Fleece Tebal',
        'first_item_image': 'https://picsum.photos/seed/hoodie_fleece/400/400',
      },
      {
        'id': 'ord_004',
        'order_number': 'STY-2026030101',
        'item_count': 1,
        'total': 299000.0,
        'status': 'selesai',
        'created_at': now.subtract(const Duration(days: 10)).toIso8601String(),
        'first_item_name': 'Dress Midi Elegant',
        'first_item_image': 'https://picsum.photos/seed/dress_midi/400/400',
      },
      {
        'id': 'ord_005',
        'order_number': 'STY-2026022001',
        'item_count': 2,
        'total': 450000.0,
        'status': 'selesai',
        'created_at': now.subtract(const Duration(days: 20)).toIso8601String(),
        'first_item_name': 'Sneakers Putih Classic',
        'first_item_image': 'https://picsum.photos/seed/sneakers_putih/400/400',
      },
    ];
  }

  // ---------------------------------------------------------------------------
  // Static notifications
  // ---------------------------------------------------------------------------
  static List<Map<String, dynamic>> _buildNotifications() {
    final now = DateTime.now();
    return [
      {
        'id': 'notif_001',
        'title': 'Pesanan Segera Dibayar!',
        'body':
            'Pesanan #STY-2026031101 menunggu pembayaran. Segera selesaikan sebelum kedaluwarsa.',
        'type': 'order_update',
        'is_read': false,
        'created_at': now.subtract(const Duration(hours: 1)).toIso8601String(),
        'image_url': 'https://picsum.photos/seed/notif_order1/80/80',
      },
      {
        'id': 'notif_002',
        'title': 'Harbolnas Sale Dimulai!',
        'body':
            'Nikmati diskon hingga 70% untuk ribuan produk fashion pilihan. Jangan sampai ketinggalan!',
        'type': 'promo',
        'is_read': false,
        'created_at': now.subtract(const Duration(hours: 3)).toIso8601String(),
        'image_url': 'https://picsum.photos/seed/notif_promo1/80/80',
      },
      {
        'id': 'notif_003',
        'title': 'Paket Dalam Perjalanan',
        'body':
            'Pesanan #STY-2026030701 telah diambil kurir JNE dan sedang dalam perjalanan ke lokasimu.',
        'type': 'order_update',
        'is_read': false,
        'created_at': now.subtract(const Duration(hours: 6)).toIso8601String(),
        'image_url': 'https://picsum.photos/seed/notif_order3/80/80',
      },
      {
        'id': 'notif_004',
        'title': 'Pesanan Sedang Diproses',
        'body':
            'Seller sudah mengkonfirmasi pesanan #STY-2026030901 dan sedang mempersiapkan paketmu.',
        'type': 'order_update',
        'is_read': true,
        'created_at': now.subtract(const Duration(days: 2)).toIso8601String(),
        'image_url': null,
      },
      {
        'id': 'notif_005',
        'title': 'Koleksi Lebaran Tiba!',
        'body':
            'Tampil memukau di Hari Raya dengan koleksi dress dan baju koko terbaru dari Stylo.',
        'type': 'promo',
        'is_read': true,
        'created_at': now.subtract(const Duration(days: 3)).toIso8601String(),
        'image_url': 'https://picsum.photos/seed/notif_lebaran/80/80',
      },
      {
        'id': 'notif_006',
        'title': 'Pesanan Selesai',
        'body':
            'Pesanan #STY-2026030101 telah selesai. Yuk, bagikan pengalamanmu dengan memberikan ulasan!',
        'type': 'order_update',
        'is_read': true,
        'created_at': now.subtract(const Duration(days: 10)).toIso8601String(),
        'image_url': null,
      },
      {
        'id': 'notif_007',
        'title': 'Member Eksklusif: Gratis Ongkir',
        'body':
            'Sebagai member setia Stylo, kamu mendapatkan gratis ongkir untuk semua pembelian bulan ini!',
        'type': 'promo',
        'is_read': true,
        'created_at': now.subtract(const Duration(days: 12)).toIso8601String(),
        'image_url': 'https://picsum.photos/seed/notif_member/80/80',
      },
      {
        'id': 'notif_008',
        'title': 'Pesanan Selesai',
        'body':
            'Pesanan #STY-2026022001 telah selesai. Bagikan foto outfitmu dan tag @stylo.id!',
        'type': 'order_update',
        'is_read': true,
        'created_at': now.subtract(const Duration(days: 20)).toIso8601String(),
        'image_url': null,
      },
      {
        'id': 'notif_009',
        'title': 'Pembaruan Aplikasi Tersedia',
        'body':
            'Versi terbaru Stylo kini hadir dengan fitur AI Try-On yang lebih canggih dan tampilan baru!',
        'type': 'system',
        'is_read': true,
        'created_at': now.subtract(const Duration(days: 25)).toIso8601String(),
        'image_url': null,
      },
      {
        'id': 'notif_010',
        'title': 'New Arrival: Koleksi Terbaru',
        'body':
            'Outfit terkini sudah tiba di Stylo! Dapatkan pilihan terbaik sebelum kehabisan stok.',
        'type': 'promo',
        'is_read': true,
        'created_at': now.subtract(const Duration(days: 30)).toIso8601String(),
        'image_url': 'https://picsum.photos/seed/notif_newarrival/80/80',
      },
    ];
  }

  // ---------------------------------------------------------------------------
  // Main dispatcher
  // ---------------------------------------------------------------------------
  static Map<String, dynamic> getMockResponse(
    String path, {
    String method = 'GET',
    Map<String, dynamic>? body,
    Map<String, String>? queryParams,
  }) {
    // ---- Auth ----------------------------------------------------------------
    if (path == ApiConstants.login ||
        path == ApiConstants.register ||
        path == ApiConstants.me) {
      return {
        'message': 'Success',
        'data': {
          'id': 'user_rizki_01',
          'email': 'rizki.pratama@gmail.com',
          'name': 'Rizki Pratama',
          'phone': '081234567890',
          'avatar_url': 'https://i.pravatar.cc/150?u=rizki',
          'style_preferences': ['Casual', 'Streetwear'],
          'token': 'mock_jwt_token_rizki_12345',
        },
      };
    }

    // ---- Home Banners --------------------------------------------------------
    if (path == '/home/banners') {
      return {
        'message': 'Success',
        'data': [
          {
            'id': 'banner_1',
            'image_url': 'https://picsum.photos/seed/harbolnas_sale/800/400',
            'title': 'Harbolnas Sale',
            'subtitle': 'Diskon s/d 70%!',
            'deep_link': '/products',
          },
          {
            'id': 'banner_2',
            'image_url': 'https://picsum.photos/seed/koleksi_lebaran/800/400',
            'title': 'Koleksi Lebaran',
            'subtitle': 'Tampil Memukau di Hari Raya',
            'deep_link': '/products?category=Dress',
          },
          {
            'id': 'banner_3',
            'image_url': 'https://picsum.photos/seed/member_eksklusif/800/400',
            'title': 'Member Eksklusif',
            'subtitle': 'Gratis Ongkir Semua Produk',
            'deep_link': '/promo/member',
          },
          {
            'id': 'banner_4',
            'image_url':
                'https://picsum.photos/seed/new_arrival_wanita/800/400',
            'title': 'New Arrival',
            'subtitle': 'Outfit Terkini Buat Kamu',
            'deep_link': '/products?category=Pakaian Wanita',
          },
        ],
      };
    }

    // ---- Categories ----------------------------------------------------------
    if (path == ApiConstants.categories) {
      return {
        'message': 'Success',
        'data': [
          {
            'id': 'cat_pria',
            'name': 'Pakaian Pria',
            'icon_url': 'https://picsum.photos/seed/cat_pria/80',
          },
          {
            'id': 'cat_wanita',
            'name': 'Pakaian Wanita',
            'icon_url': 'https://picsum.photos/seed/cat_wanita/80',
          },
          {
            'id': 'cat_dress',
            'name': 'Dress',
            'icon_url': 'https://picsum.photos/seed/cat_dress/80',
          },
          {
            'id': 'cat_outer',
            'name': 'Outerwear',
            'icon_url': 'https://picsum.photos/seed/cat_outer/80',
          },
          {
            'id': 'cat_aksesoris',
            'name': 'Aksesoris',
            'icon_url': 'https://picsum.photos/seed/cat_aksesoris/80',
          },
          {
            'id': 'cat_sepatu',
            'name': 'Sepatu',
            'icon_url': 'https://picsum.photos/seed/cat_sepatu/80',
          },
        ],
      };
    }

    // ---- Product Reviews -----------------------------------------------------
    if (path.contains('/reviews')) {
      final now = DateTime.now();
      return {
        'message': 'Success',
        'data': [
          {
            'id': 'rev_001',
            'author_name': 'Siti Rahma',
            'avatar_url': 'https://i.pravatar.cc/80?u=siti_rahma',
            'rating': 5,
            'comment':
                'Produk sangat bagus dan sesuai deskripsi! Kualitas bahan premium, pengiriman cepat. '
                'Pasti beli lagi di Stylo, recommended banget!',
            'created_at': now
                .subtract(const Duration(days: 2))
                .toIso8601String(),
          },
          {
            'id': 'rev_002',
            'author_name': 'Budi Santoso',
            'avatar_url': 'https://i.pravatar.cc/80?u=budi_santoso',
            'rating': 4,
            'comment':
                'Kualitas bagus, bahan nyaman dipakai. Ukurannya sesuai chart, pas di badan. '
                'Sedikit lebih gelap dari foto tapi masih oke.',
            'created_at': now
                .subtract(const Duration(days: 5))
                .toIso8601String(),
          },
          {
            'id': 'rev_003',
            'author_name': 'Dewi Anggraeni',
            'avatar_url': 'https://i.pravatar.cc/80?u=dewi_anggraeni',
            'rating': 5,
            'comment':
                'Udah beli dua kali dan selalu puas! Bahannya adem dan ga gampang kusut. '
                'Packaging juga rapi banget, cocok buat hadiah.',
            'created_at': now
                .subtract(const Duration(days: 8))
                .toIso8601String(),
          },
          {
            'id': 'rev_004',
            'author_name': 'Ahmad Fauzi',
            'avatar_url': 'https://i.pravatar.cc/80?u=ahmad_fauzi',
            'rating': 4,
            'comment':
                'Overall bagus sih, sesuai ekspektasi. Bahannya tebal dan jahitannya rapi. '
                'Pengiriman juga cepat, sampai dalam 2 hari.',
            'created_at': now
                .subtract(const Duration(days: 15))
                .toIso8601String(),
          },
          {
            'id': 'rev_005',
            'author_name': 'Maya Putri',
            'avatar_url': 'https://i.pravatar.cc/80?u=maya_putri',
            'rating': 3,
            'comment':
                'Produknya lumayan, tapi warna agak berbeda dari foto. '
                'Bahan masih oke dan ukuran sesuai. Mungkin next time foto produk bisa lebih akurat.',
            'created_at': now
                .subtract(const Duration(days: 22))
                .toIso8601String(),
          },
        ],
      };
    }

    // ---- Product Detail ('/products/{id}') -----------------------------------
    if (path.startsWith('${ApiConstants.products}/') &&
        !path.contains('/reviews')) {
      final productId = path.split('/').last;
      final productIndex = _products.indexWhere((p) => p['id'] == productId);

      Map<String, dynamic> base;
      if (productIndex >= 0) {
        base = Map<String, dynamic>.from(_products[productIndex]);
      } else {
        base = Map<String, dynamic>.from(_products[0]);
      }

      // Add extra images for detail view
      final seed = base['image_url']
          .toString()
          .split('/seed/')[1]
          .split('/')[0];
      base['images'] = [
        base['image_url'],
        'https://picsum.photos/seed/${seed}_2/400/400',
        'https://picsum.photos/seed/${seed}_3/400/400',
        'https://picsum.photos/seed/${seed}_4/400/400',
      ];

      return {'message': 'Success', 'data': base};
    }

    // ---- Products List -------------------------------------------------------
    if (path == ApiConstants.products) {
      final category = queryParams?['category'];
      final search = queryParams?['search'];

      var filtered = _products;
      if (category != null && category != 'Semua') {
        filtered = filtered.where((p) => p['category'] == category).toList();
      }
      if (search != null && search.isNotEmpty) {
        final query = search.toLowerCase();
        filtered = filtered
            .where(
              (p) =>
                  p['name'].toString().toLowerCase().contains(query) ||
                  p['description'].toString().toLowerCase().contains(query),
            )
            .toList();
      }

      return {'message': 'Success', 'data': filtered};
    }

    // ---- Products Count ------------------------------------------------------
    if (path == ApiConstants.productCount) {
      final category = queryParams?['category'];
      final search = queryParams?['search'];

      var filtered = _products;
      if (category != null && category != 'Semua') {
        filtered = filtered.where((p) => p['category'] == category).toList();
      }
      if (search != null && search.isNotEmpty) {
        final query = search.toLowerCase();
        filtered = filtered
            .where(
              (p) =>
                  p['name'].toString().toLowerCase().contains(query) ||
                  p['description'].toString().toLowerCase().contains(query),
            )
            .toList();
      }

      // For debugging/demo, let's assume if no filter, total is always 100
      // but if we have mock data, use its length.
      // User mentioned 100 items total, so let's mock that if unfiltered.
      final total = (category == null && search == null)
          ? 100
          : filtered.length;

      return {
        'message': 'Success',
        'data': {'total': total},
      };
    }

    // ---- Try-On --------------------------------------------------------------
    if (path == ApiConstants.tryOn) {
      return {
        'message': 'Try-on task generated',
        'data': {
          'task_id': 'mock_task_id_${_random.nextInt(1000)}',
          'status': 'processing',
        },
      };
    }

    if (path == ApiConstants.tryOnAvatars) {
      return {
        'message': 'Success',
        'data': [
          {
            'id': 'avatar_1',
            'name': 'Avatar 1',
            'image_url': 'https://i.pravatar.cc/200?u=avatar1',
          },
          {
            'id': 'avatar_2',
            'name': 'Avatar 2',
            'image_url': 'https://i.pravatar.cc/200?u=avatar2',
          },
        ],
      };
    }

    if (path == ApiConstants.tryOnResults) {
      return {
        'message': 'Success',
        'data': {
          'result_url': 'https://picsum.photos/seed/tryon_result/400/600',
          'status': 'completed',
        },
      };
    }

    // ---- Cart ----------------------------------------------------------------
    if (path.startsWith(ApiConstants.cart)) {
      return {
        'message': 'Success',
        'data': {
          'items': [
            {
              'id': 'cart_item_1',
              'product_id': 'prod_1',
              'product_name': 'Kaos Oversize Streetwear',
              'product_image':
                  'https://picsum.photos/seed/kaos_oversize/400/400',
              'price': 129000.0,
              'quantity': 2,
              'size': 'L',
              'color': 'Hitam',
            },
            {
              'id': 'cart_item_2',
              'product_id': 'prod_11',
              'product_name': 'Topi Bucket Hat',
              'product_image': 'https://picsum.photos/seed/bucket_hat/400/400',
              'price': 79000.0,
              'quantity': 1,
              'size': 'ONE SIZE',
              'color': 'Navy',
            },
          ],
          'subtotal': 337000,
          'total': 337000,
        },
      };
    }

    // ---- Checkout: Addresses -------------------------------------------------
    if (path == ApiConstants.checkoutAddresses) {
      return {
        'message': 'Success',
        'data': [
          {
            'id': 'addr_1',
            'label': 'Rumah',
            'recipient_name': 'Rizki Pratama',
            'phone_number': '081234567890',
            'full_address': 'Jl. Kemang Raya No. 15, RT 03/RW 07',
            'city': 'Jakarta Selatan',
            'province': 'DKI Jakarta',
            'postal_code': '12730',
            'is_default': true,
          },
          {
            'id': 'addr_2',
            'label': 'Kantor',
            'recipient_name': 'Rizki Pratama',
            'phone_number': '081234567890',
            'full_address': 'Jl. Jend. Sudirman Kav. 52-53, Senayan',
            'city': 'Jakarta Pusat',
            'province': 'DKI Jakarta',
            'postal_code': '10270',
            'is_default': false,
          },
        ],
      };
    }

    // ---- Checkout: Shipping Rates -------------------------------------------
    if (path == ApiConstants.checkoutShipping) {
      return {
        'message': 'Success',
        'data': [
          {
            'id': 'ship_jne_reg',
            'name': 'JNE Reguler',
            'price': 15000,
            'estimated_days': '2-3 Hari Kerja',
          },
          {
            'id': 'ship_jne_oke',
            'name': 'JNE OKE',
            'price': 9000,
            'estimated_days': '3-5 Hari Kerja',
          },
          {
            'id': 'ship_sicepat',
            'name': 'SiCepat BEST',
            'price': 22000,
            'estimated_days': '1-2 Hari Kerja',
          },
        ],
      };
    }

    // ---- Checkout: Payment Methods ------------------------------------------
    if (path == ApiConstants.checkoutPayments) {
      return {
        'message': 'Success',
        'data': [
          {
            'id': 'pay_gopay',
            'name': 'GoPay',
            'type': 'ewallet',
            'icon_url': 'https://picsum.photos/seed/gopay_icon/80',
          },
          {
            'id': 'pay_ovo',
            'name': 'OVO',
            'type': 'ewallet',
            'icon_url': 'https://picsum.photos/seed/ovo_icon/80',
          },
          {
            'id': 'pay_bca',
            'name': 'BCA Virtual Account',
            'type': 'virtual_account',
            'icon_url': 'https://picsum.photos/seed/bca_icon/80',
          },
          {
            'id': 'pay_mandiri',
            'name': 'Mandiri Virtual Account',
            'type': 'virtual_account',
            'icon_url': 'https://picsum.photos/seed/mandiri_icon/80',
          },
        ],
      };
    }

    // ---- Checkout: Place Order -----------------------------------------------
    if (path == ApiConstants.checkoutPlaceOrder) {
      return {
        'message': 'Pesanan berhasil dibuat',
        'data': {
          'id': 'ord_${_random.nextInt(90000) + 10000}',
          'order_number': 'STY-${DateTime.now().millisecondsSinceEpoch}',
          'status': 'menunggu_pembayaran',
          'total_amount': 351000,
          'payment_info': {
            'virtual_account_number':
                '8800${_random.nextInt(900000000) + 100000000}',
            'expires_at': DateTime.now()
                .add(const Duration(hours: 24))
                .toIso8601String(),
          },
        },
      };
    }

    // ---- Orders List ---------------------------------------------------------
    if (path == ApiConstants.orders) {
      return {'message': 'Success', 'data': _buildOrders()};
    }

    // ---- Order Detail ('/orders/{id}') ---------------------------------------
    if (path.startsWith('${ApiConstants.orders}/')) {
      final orderId = path.split('/').last;
      final now = DateTime.now();

      // Return different detail per order id
      final Map<String, Map<String, dynamic>> orderDetails = {
        'ord_001': {
          'id': 'ord_001',
          'order_number': 'STY-2026031101',
          'status': 'menunggu_pembayaran',
          'subtotal': 318000.0,
          'shipping_cost': 15000.0,
          'discount': 0.0,
          'total': 345000.0,
          'payment_method': 'GoPay',
          'payment_info': {
            'virtual_account_number': '8800123456789',
            'expires_at': now.add(const Duration(hours: 23)).toIso8601String(),
          },
          'shipping_courier': 'JNE',
          'shipping_service': 'Reguler',
          'tracking_number': null,
          'receiver_name': 'Rizki Pratama',
          'address':
              'Jl. Kemang Raya No. 15, RT 03/RW 07, Jakarta Selatan 12730',
          'phone': '081234567890',
          'created_at': now
              .subtract(const Duration(hours: 1))
              .toIso8601String(),
          'items': [
            {
              'product_id': 'prod_0',
              'product_name': 'Kemeja Oxford Slim Fit',
              'quantity': 1,
              'price': 189000.0,
              'size': 'M',
              'color': 'Putih',
              'product_image':
                  'https://picsum.photos/seed/kemeja_oxford/400/400',
            },
            {
              'product_id': 'prod_11',
              'product_name': 'Topi Bucket Hat',
              'quantity': 1,
              'price': 79000.0,
              'size': 'ONE SIZE',
              'color': 'Navy',
              'product_image': 'https://picsum.photos/seed/bucket_hat/400/400',
            },
          ],
        },
        'ord_002': {
          'id': 'ord_002',
          'order_number': 'STY-2026030901',
          'status': 'diproses',
          'subtotal': 129000.0,
          'shipping_cost': 22000.0,
          'discount': 0.0,
          'total': 198000.0,
          'payment_method': 'OVO',
          'payment_info': null,
          'shipping_courier': 'SiCepat',
          'shipping_service': 'BEST',
          'tracking_number': null,
          'receiver_name': 'Rizki Pratama',
          'address':
              'Jl. Kemang Raya No. 15, RT 03/RW 07, Jakarta Selatan 12730',
          'phone': '081234567890',
          'created_at': now.subtract(const Duration(days: 2)).toIso8601String(),
          'items': [
            {
              'product_id': 'prod_6',
              'product_name': 'Blouse Floral Chiffon',
              'quantity': 1,
              'price': 129000.0,
              'size': 'S',
              'color': 'Putih',
              'product_image':
                  'https://picsum.photos/seed/blouse_floral/400/400',
            },
          ],
        },
        'ord_003': {
          'id': 'ord_003',
          'order_number': 'STY-2026030701',
          'status': 'dikirim',
          'subtotal': 536000.0,
          'shipping_cost': 15000.0,
          'discount': 0.0,
          'total': 567000.0,
          'payment_method': 'BCA Virtual Account',
          'payment_info': null,
          'shipping_courier': 'JNE',
          'shipping_service': 'Reguler',
          'tracking_number': 'JNE123456789ID',
          'receiver_name': 'Rizki Pratama',
          'address':
              'Jl. Jend. Sudirman Kav. 52-53, Senayan, Jakarta Pusat 10270',
          'phone': '081234567890',
          'created_at': now.subtract(const Duration(days: 4)).toIso8601String(),
          'items': [
            {
              'product_id': 'prod_4',
              'product_name': 'Hoodie Fleece Tebal',
              'quantity': 1,
              'price': 329000.0,
              'size': 'L',
              'color': 'Abu-abu',
              'product_image':
                  'https://picsum.photos/seed/hoodie_fleece/400/400',
            },
            {
              'product_id': 'prod_1',
              'product_name': 'Kaos Oversize Streetwear',
              'quantity': 1,
              'price': 129000.0,
              'size': 'XL',
              'color': 'Hitam',
              'product_image':
                  'https://picsum.photos/seed/kaos_oversize/400/400',
            },
            {
              'product_id': 'prod_10',
              'product_name': 'Tote Bag Canvas',
              'quantity': 1,
              'price': 89000.0,
              'size': 'ONE SIZE',
              'color': 'Krem',
              'product_image': 'https://picsum.photos/seed/tote_bag/400/400',
            },
          ],
        },
        'ord_004': {
          'id': 'ord_004',
          'order_number': 'STY-2026030101',
          'status': 'selesai',
          'subtotal': 299000.0,
          'shipping_cost': 0.0,
          'discount': 0.0,
          'total': 299000.0,
          'payment_method': 'GoPay',
          'payment_info': null,
          'shipping_courier': 'JNE',
          'shipping_service': 'OKE',
          'tracking_number': 'JNE987654321ID',
          'receiver_name': 'Rizki Pratama',
          'address':
              'Jl. Kemang Raya No. 15, RT 03/RW 07, Jakarta Selatan 12730',
          'phone': '081234567890',
          'created_at': now
              .subtract(const Duration(days: 10))
              .toIso8601String(),
          'items': [
            {
              'product_id': 'prod_7',
              'product_name': 'Dress Midi Elegant',
              'quantity': 1,
              'price': 299000.0,
              'size': 'M',
              'color': 'Hitam',
              'product_image': 'https://picsum.photos/seed/dress_midi/400/400',
            },
          ],
        },
        'ord_005': {
          'id': 'ord_005',
          'order_number': 'STY-2026022001',
          'status': 'selesai',
          'subtotal': 428000.0,
          'shipping_cost': 22000.0,
          'discount': 0.0,
          'total': 450000.0,
          'payment_method': 'Mandiri Virtual Account',
          'payment_info': null,
          'shipping_courier': 'SiCepat',
          'shipping_service': 'BEST',
          'tracking_number': 'SCP567891234ID',
          'receiver_name': 'Rizki Pratama',
          'address':
              'Jl. Kemang Raya No. 15, RT 03/RW 07, Jakarta Selatan 12730',
          'phone': '081234567890',
          'created_at': now
              .subtract(const Duration(days: 20))
              .toIso8601String(),
          'items': [
            {
              'product_id': 'prod_12',
              'product_name': 'Sneakers Putih Classic',
              'quantity': 1,
              'price': 499000.0,
              'size': '40',
              'color': 'Putih',
              'product_image':
                  'https://picsum.photos/seed/sneakers_putih/400/400',
            },
            {
              'product_id': 'prod_19',
              'product_name': 'Kalung Emas Minimalis',
              'quantity': 1,
              'price': 139000.0,
              'size': '45cm',
              'color': 'Krem',
              'product_image': 'https://picsum.photos/seed/kalung_emas/400/400',
            },
          ],
        },
      };

      final detail = orderDetails[orderId];
      if (detail != null) {
        return {'message': 'Success', 'data': detail};
      }

      // Fallback for unknown order id
      return {'message': 'Success', 'data': orderDetails['ord_001']};
    }

    // ---- Notifications -------------------------------------------------------
    if (path == '/notifications') {
      return {'message': 'Success', 'data': _buildNotifications()};
    }

    // ---- Wishlist ------------------------------------------------------------
    if (path == '/wishlist') {
      if (method == 'GET') {
        return {
          'message': 'Success',
          'data': {
            'product_ids': ['prod_0', 'prod_3', 'prod_7'],
          },
        };
      } else {
        // POST or DELETE
        return {'message': 'Success'};
      }
    }

    // ---- Profile -------------------------------------------------------------
    if (path == ApiConstants.profile) {
      // Handle PUT request for profile update
      if (method == 'PUT') {
        return {
          'message': 'Profile updated successfully',
          'data': {
            'id': 'user_rizki_01',
            'email': 'rizki.pratama@gmail.com',
            'name': body?['name'] ?? 'Rizki Pratama',
            'phone': body?['phone'] ?? '081234567890',
            'avatar_url': 'https://i.pravatar.cc/150?u=rizki',
            'style_preferences': ['Casual', 'Streetwear'],
          },
        };
      }
      // GET request
      return {
        'message': 'Success',
        'data': {
          'id': 'user_rizki_01',
          'email': 'rizki.pratama@gmail.com',
          'name': 'Rizki Pratama',
          'phone': '081234567890',
          'avatar_url': 'https://i.pravatar.cc/150?u=rizki',
          'style_preferences': ['Casual', 'Streetwear'],
        },
      };
    }

    if (path == '${ApiConstants.profile}/style-preferences') {
      // Handle PUT request for updating style preferences
      if (method == 'PUT') {
        return {
          'message': 'Style preferences updated successfully',
          'data': null,
        };
      }
      // GET request
      return {
        'message': 'Success',
        'data': [
          {'id': 'style_casual', 'name': 'Casual', 'is_selected': true},
          {'id': 'style_streetwear', 'name': 'Streetwear', 'is_selected': true},
          {'id': 'style_formal', 'name': 'Formal', 'is_selected': false},
          {'id': 'style_vintage', 'name': 'Vintage', 'is_selected': false},
          {'id': 'style_sporty', 'name': 'Sporty', 'is_selected': false},
          {'id': 'style_bohemian', 'name': 'Bohemian', 'is_selected': false},
          {
            'id': 'style_minimalist',
            'name': 'Minimalist',
            'is_selected': false,
          },
        ],
      };
    }

    // ---- Default fallback ----------------------------------------------------
    return {'message': 'Mock Route Not Defined', 'data': []};
  }
}
