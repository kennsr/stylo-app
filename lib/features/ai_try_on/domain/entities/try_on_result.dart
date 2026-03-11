import 'package:freezed_annotation/freezed_annotation.dart';

part 'try_on_result.freezed.dart';

@freezed
abstract class TryOnResult with _$TryOnResult {
  const factory TryOnResult({
    required String id,
    required String productId,
    required String originalImageUrl,
    required String resultImageUrl,
    required DateTime createdAt,
    @Default(false) bool isSaved,
  }) = _TryOnResult;
}
