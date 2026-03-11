import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/user.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
abstract class UserModel with _$UserModel {
  const UserModel._();

  const factory UserModel({
    required String id,
    required String email,
    required String name,
    String? phone,
    @JsonKey(name: 'avatar_url') String? avatarUrl,
    @Default([])
    @JsonKey(name: 'style_preferences')
    List<String> stylePreferences,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  User toEntity() => User(
    id: id,
    email: email,
    name: name,
    phone: phone,
    avatarUrl: avatarUrl,
    stylePreferences: stylePreferences,
  );

  factory UserModel.fromEntity(User user) => UserModel(
    id: user.id,
    email: user.email,
    name: user.name,
    phone: user.phone,
    avatarUrl: user.avatarUrl,
    stylePreferences: user.stylePreferences,
  );
}
