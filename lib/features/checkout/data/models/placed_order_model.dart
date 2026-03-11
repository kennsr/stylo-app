import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/placed_order.dart';
import 'cart_item_ref_model.dart';
import 'shipping_address_model.dart';
import 'shipping_option_model.dart';

part 'placed_order_model.freezed.dart';
part 'placed_order_model.g.dart';

@freezed
abstract class PlacedOrderModel with _$PlacedOrderModel {
  const factory PlacedOrderModel({
    required String id,
    @JsonKey(name: 'order_number') required String orderNumber,
    required List<CartItemRefModel> items,
    required ShippingAddressModel address,
    required ShippingOptionModel shipping,
    @JsonKey(name: 'payment_method') required String paymentMethod,
    required double subtotal,
    @JsonKey(name: 'shipping_cost') required double shippingCost,
    required double total,
    required String status,
    @JsonKey(name: 'created_at') required DateTime createdAt,
  }) = _PlacedOrderModel;

  factory PlacedOrderModel.fromJson(Map<String, dynamic> json) =>
      _$PlacedOrderModelFromJson(json);
}

extension PlacedOrderModelX on PlacedOrderModel {
  PlacedOrder toEntity() {
    return PlacedOrder(
      id: id,
      orderNumber: orderNumber,
      items: items.map((i) => i.toEntity()).toList(),
      address: address.toEntity(),
      shipping: shipping.toEntity(),
      paymentMethod: paymentMethod,
      subtotal: subtotal,
      shippingCost: shippingCost,
      total: total,
      status: status,
      createdAt: createdAt,
    );
  }
}
