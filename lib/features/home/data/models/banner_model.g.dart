// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'banner_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_BannerModel _$BannerModelFromJson(Map<String, dynamic> json) => _BannerModel(
  id: json['id'] as String,
  imageUrl: json['image_url'] as String,
  title: json['title'] as String?,
  subtitle: json['subtitle'] as String?,
  deepLink: json['deep_link'] as String?,
);

Map<String, dynamic> _$BannerModelToJson(_BannerModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'image_url': instance.imageUrl,
      'title': instance.title,
      'subtitle': instance.subtitle,
      'deep_link': instance.deepLink,
    };
