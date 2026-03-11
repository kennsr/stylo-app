import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/try_on_result.dart';

part 'try_on_result_model.freezed.dart';
part 'try_on_result_model.g.dart';

@freezed
abstract class TryOnResultModel with _$TryOnResultModel {
  const factory TryOnResultModel({
    required String id,
    @JsonKey(name: 'product_id') required String productId,
    @JsonKey(name: 'original_image_url') required String originalImageUrl,
    @JsonKey(name: 'result_image_url') required String resultImageUrl,
    @JsonKey(name: 'created_at') required DateTime createdAt,
    @JsonKey(name: 'is_saved') @Default(false) bool isSaved,
  }) = _TryOnResultModel;

  factory TryOnResultModel.fromJson(Map<String, dynamic> json) =>
      _$TryOnResultModelFromJson(json);
}

extension TryOnResultModelX on TryOnResultModel {
  TryOnResult toEntity() {
    return TryOnResult(
      id: id,
      productId: productId,
      originalImageUrl: originalImageUrl,
      resultImageUrl: resultImageUrl,
      createdAt: createdAt,
      isSaved: isSaved,
    );
  }
}
