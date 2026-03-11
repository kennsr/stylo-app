import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/fit_profile.dart';

part 'fit_profile_model.freezed.dart';
part 'fit_profile_model.g.dart';

@freezed
abstract class FitProfileModel with _$FitProfileModel {
  const factory FitProfileModel({
    @JsonKey(name: 'user_id') String? userId,
    double? height,
    double? weight,
    double? chest,
    double? waist,
    double? hips,
    @JsonKey(name: 'preferred_size') String? preferredSize,
  }) = _FitProfileModel;

  factory FitProfileModel.fromJson(Map<String, dynamic> json) =>
      _$FitProfileModelFromJson(json);
}

extension FitProfileModelX on FitProfileModel {
  FitProfile toEntity() {
    return FitProfile(
      userId: userId,
      height: height,
      weight: weight,
      chest: chest,
      waist: waist,
      hips: hips,
      preferredSize: preferredSize,
    );
  }
}

extension FitProfileX on FitProfile {
  FitProfileModel toModel() {
    return FitProfileModel(
      userId: userId,
      height: height,
      weight: weight,
      chest: chest,
      waist: waist,
      hips: hips,
      preferredSize: preferredSize,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (userId != null) 'user_id': userId,
      if (height != null) 'height': height,
      if (weight != null) 'weight': weight,
      if (chest != null) 'chest': chest,
      if (waist != null) 'waist': waist,
      if (hips != null) 'hips': hips,
      if (preferredSize != null) 'preferred_size': preferredSize,
    };
  }
}
