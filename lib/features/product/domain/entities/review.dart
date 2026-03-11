import 'package:freezed_annotation/freezed_annotation.dart';

part 'review.freezed.dart';

@freezed
abstract class Review with _$Review {
  const factory Review({
    required String id,
    required String userId,
    required String userName,
    String? userAvatar,
    required double rating,
    required String comment,
    required DateTime createdAt,
    @Default([]) List<String> images,
  }) = _Review;
}
