// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'style_preference_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_StylePreferenceModel _$StylePreferenceModelFromJson(
  Map<String, dynamic> json,
) => _StylePreferenceModel(
  id: json['id'] as String,
  name: json['name'] as String,
  isSelected: json['is_selected'] as bool? ?? false,
);

Map<String, dynamic> _$StylePreferenceModelToJson(
  _StylePreferenceModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'is_selected': instance.isSelected,
};
