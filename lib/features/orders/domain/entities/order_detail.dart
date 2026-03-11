import 'package:freezed_annotation/freezed_annotation.dart';

part 'order_detail.freezed.dart';

@freezed
abstract class OrderDetail with _$OrderDetail {
  const factory OrderDetail({
    required String id,
    required String orderNumber,
    required String status,
    required double subtotal,
    required double shippingCost,
    required double total,
    required String paymentMethod,
    required String shippingCourier,
    required String shippingService,
    required String receiverName,
    required String address,
    required String phone,
    required DateTime createdAt,
    @Default([]) List<OrderItem> items,
  }) = _OrderDetail;
}

@freezed
abstract class OrderItem with _$OrderItem {
  const factory OrderItem({
    required String productId,
    required String productName,
    required int quantity,
    required double price,
    required String size,
    required String color,
    String? productImage,
  }) = _OrderItem;
}
