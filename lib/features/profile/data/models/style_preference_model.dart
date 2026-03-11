import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/style_preference.dart';

part 'style_preference_model.freezed.dart';
part 'style_preference_model.g.dart';

@freezed
abstract class StylePreferenceModel with _$StylePreferenceModel {
  const factory StylePreferenceModel({
    required String id,
    required String name,
    @JsonKey(name: 'is_selected') @Default(false) bool isSelected,
  }) = _StylePreferenceModel;

  factory StylePreferenceModel.fromJson(Map<String, dynamic> json) =>
      _$StylePreferenceModelFromJson(json);
}

extension StylePreferenceModelX on StylePreferenceModel {
  StylePreference toEntity() {
    return StylePreference(
      id: id,
      name: name,
      isSelected: isSelected,
    );
  }
}
