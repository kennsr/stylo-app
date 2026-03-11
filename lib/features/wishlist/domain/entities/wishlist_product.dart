import 'package:equatable/equatable.dart';

/// Lightweight product snapshot stored in wishlist.
/// Keeps all display info so WishlistPage is self-contained (no extra API call).
class WishlistProduct extends Equatable {
  final String id;
  final String name;
  final double price;
  final double? discountPrice;
  final String imageUrl;
  final String category;
  final double rating;

  const WishlistProduct({
    required this.id,
    required this.name,
    required this.price,
    this.discountPrice,
    required this.imageUrl,
    required this.category,
    required this.rating,
  });

  double get displayPrice => discountPrice ?? price;

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'price': price,
        'discount_price': discountPrice,
        'image_url': imageUrl,
        'category': category,
        'rating': rating,
      };

  factory WishlistProduct.fromJson(Map<String, dynamic> json) =>
      WishlistProduct(
        id: json['id'] as String,
        name: json['name'] as String,
        price: (json['price'] as num).toDouble(),
        discountPrice: json['discount_price'] != null
            ? (json['discount_price'] as num).toDouble()
            : null,
        imageUrl: json['image_url'] as String,
        category: json['category'] as String,
        rating: (json['rating'] as num).toDouble(),
      );

  @override
  List<Object?> get props =>
      [id, name, price, discountPrice, imageUrl, category, rating];
}
