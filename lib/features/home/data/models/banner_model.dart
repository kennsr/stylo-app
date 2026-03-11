import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/banner.dart';

part 'banner_model.freezed.dart';
part 'banner_model.g.dart';

@freezed
abstract class BannerModel with _$BannerModel {
  const BannerModel._();

  const factory BannerModel({
    required String id,
    @JsonKey(name: 'image_url') required String imageUrl,
    String? title,
    String? subtitle,
    @JsonKey(name: 'deep_link') String? deepLink,
  }) = _BannerModel;

  factory BannerModel.fromJson(Map<String, dynamic> json) =>
      _$BannerModelFromJson(json);

  Banner toEntity() => Banner(
    id: id,
    imageUrl: imageUrl,
    title: title,
    subtitle: subtitle,
    deepLink: deepLink,
  );
}
