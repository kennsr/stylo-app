import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/order_detail.dart';

part 'order_detail_model.freezed.dart';
part 'order_detail_model.g.dart';

@freezed
abstract class OrderItemModel with _$OrderItemModel {
  const factory OrderItemModel({
    @JsonKey(name: 'product_id') required String productId,
    @JsonKey(name: 'product_name') required String productName,
    required int quantity,
    required double price,
    required String size,
    required String color,
    @JsonKey(name: 'product_image') String? productImage,
  }) = _OrderItemModel;

  factory OrderItemModel.fromJson(Map<String, dynamic> json) =>
      _$OrderItemModelFromJson(json);
}

extension OrderItemModelX on OrderItemModel {
  OrderItem toEntity() {
    return OrderItem(
      productId: productId,
      productName: productName,
      quantity: quantity,
      price: price,
      size: size,
      color: color,
      productImage: productImage,
    );
  }
}

@freezed
abstract class OrderDetailModel with _$OrderDetailModel {
  const factory OrderDetailModel({
    required String id,
    @JsonKey(name: 'order_number') required String orderNumber,
    required String status,
    required double subtotal,
    @JsonKey(name: 'shipping_cost') required double shippingCost,
    required double total,
    @JsonKey(name: 'payment_method') required String paymentMethod,
    @JsonKey(name: 'shipping_courier') required String shippingCourier,
    @JsonKey(name: 'shipping_service') required String shippingService,
    @JsonKey(name: 'receiver_name') required String receiverName,
    required String address,
    required String phone,
    @JsonKey(name: 'created_at') required DateTime createdAt,
    @Default([]) List<OrderItemModel> items,
  }) = _OrderDetailModel;

  factory OrderDetailModel.fromJson(Map<String, dynamic> json) =>
      _$OrderDetailModelFromJson(json);
}

extension OrderDetailModelX on OrderDetailModel {
  OrderDetail toEntity() {
    return OrderDetail(
      id: id,
      orderNumber: orderNumber,
      status: status,
      subtotal: subtotal,
      shippingCost: shippingCost,
      total: total,
      paymentMethod: paymentMethod,
      shippingCourier: shippingCourier,
      shippingService: shippingService,
      receiverName: receiverName,
      address: address,
      phone: phone,
      createdAt: createdAt,
      items: items.map((i) => i.toEntity()).toList(),
    );
  }
}
