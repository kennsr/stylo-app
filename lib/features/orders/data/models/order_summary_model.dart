import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/order_summary.dart';

part 'order_summary_model.freezed.dart';
part 'order_summary_model.g.dart';

@freezed
abstract class OrderSummaryModel with _$OrderSummaryModel {
  const factory OrderSummaryModel({
    required String id,
    @JsonKey(name: 'order_number') required String orderNumber,
    @JsonKey(name: 'item_count') required int itemCount,
    required double total,
    required String status,
    @JsonKey(name: 'created_at') required DateTime createdAt,
    @JsonKey(name: 'first_item_image') String? firstItemImage,
    @JsonKey(name: 'first_item_name') String? firstItemName,
  }) = _OrderSummaryModel;

  factory OrderSummaryModel.fromJson(Map<String, dynamic> json) =>
      _$OrderSummaryModelFromJson(json);
}

extension OrderSummaryModelX on OrderSummaryModel {
  OrderSummary toEntity() {
    return OrderSummary(
      id: id,
      orderNumber: orderNumber,
      itemCount: itemCount,
      total: total,
      status: status,
      createdAt: createdAt,
      firstItemImage: firstItemImage,
      firstItemName: firstItemName,
    );
  }
}
