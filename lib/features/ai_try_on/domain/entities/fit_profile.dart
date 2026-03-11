import 'package:freezed_annotation/freezed_annotation.dart';

part 'fit_profile.freezed.dart';

@freezed
abstract class FitProfile with _$FitProfile {
  const factory FitProfile({
    String? userId,
    double? height,
    double? weight,
    double? chest,
    double? waist,
    double? hips,
    String? preferredSize,
  }) = _FitProfile;
}
