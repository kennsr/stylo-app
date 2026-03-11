import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/review.dart';

part 'review_model.freezed.dart';
part 'review_model.g.dart';

@freezed
abstract class ReviewModel with _$ReviewModel {
  const factory ReviewModel({
    required String id,
    @JsonKey(name: 'user_id') required String userId,
    @JsonKey(name: 'user_name') required String userName,
    @JsonKey(name: 'user_avatar') String? userAvatar,
    required double rating,
    required String comment,
    @JsonKey(name: 'created_at') required DateTime createdAt,
    @Default([]) List<String> images,
  }) = _ReviewModel;

  factory ReviewModel.fromJson(Map<String, dynamic> json) =>
      _$ReviewModelFromJson(json);
}

extension ReviewModelX on ReviewModel {
  Review toEntity() {
    return Review(
      id: id,
      userId: userId,
      userName: userName,
      userAvatar: userAvatar,
      rating: rating,
      comment: comment,
      createdAt: createdAt,
      images: images,
    );
  }
}
