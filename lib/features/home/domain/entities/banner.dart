import 'package:freezed_annotation/freezed_annotation.dart';

part 'banner.freezed.dart';

@freezed
abstract class Banner with _$Banner {
  const factory Banner({
    required String id,
    required String imageUrl,
    String? title,
    String? subtitle,
    String? deepLink,
  }) = _Banner;
}
