// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fit_profile_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_FitProfileModel _$FitProfileModelFromJson(Map<String, dynamic> json) =>
    _FitProfileModel(
      userId: json['user_id'] as String?,
      height: (json['height'] as num?)?.toDouble(),
      weight: (json['weight'] as num?)?.toDouble(),
      chest: (json['chest'] as num?)?.toDouble(),
      waist: (json['waist'] as num?)?.toDouble(),
      hips: (json['hips'] as num?)?.toDouble(),
      preferredSize: json['preferred_size'] as String?,
    );

Map<String, dynamic> _$FitProfileModelToJson(_FitProfileModel instance) =>
    <String, dynamic>{
      'user_id': instance.userId,
      'height': instance.height,
      'weight': instance.weight,
      'chest': instance.chest,
      'waist': instance.waist,
      'hips': instance.hips,
      'preferred_size': instance.preferredSize,
    };
