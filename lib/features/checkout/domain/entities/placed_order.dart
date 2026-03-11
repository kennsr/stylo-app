import 'package:freezed_annotation/freezed_annotation.dart';
import 'cart_item_ref.dart';
import 'shipping_address.dart';
import 'shipping_option.dart';

part 'placed_order.freezed.dart';

@freezed
abstract class PlacedOrder with _$PlacedOrder {
  const factory PlacedOrder({
    required String id,
    required String orderNumber,
    required List<CartItemRef> items,
    required ShippingAddress address,
    required ShippingOption shipping,
    required String paymentMethod,
    required double subtotal,
    required double shippingCost,
    required double total,
    required String status,
    required DateTime createdAt,
  }) = _PlacedOrder;
}
