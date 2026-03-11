import 'package:freezed_annotation/freezed_annotation.dart';

part 'style_preference.freezed.dart';

@freezed
abstract class StylePreference with _$StylePreference {
  const factory StylePreference({
    required String id,
    required String name,
    @Default(false) bool isSelected,
  }) = _StylePreference;
}
