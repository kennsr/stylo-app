import 'package:freezed_annotation/freezed_annotation.dart';

part 'order_summary.freezed.dart';

@freezed
abstract class OrderSummary with _$OrderSummary {
  const factory OrderSummary({
    required String id,
    required String orderNumber,
    required int itemCount,
    required double total,
    required String status,
    required DateTime createdAt,
    String? firstItemImage,
    String? firstItemName,
  }) = _OrderSummary;
}
