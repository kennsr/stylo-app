import 'dart:io';

import '../../../../core/errors/failures.dart';
import '../../../../core/utils/either.dart';
import '../../../../features/auth/domain/entities/user.dart';
import '../entities/style_preference.dart';

abstract class ProfileRepository {
  Future<Either<Failure, User>> getProfile();
  Future<Either<Failure, User>> updateProfile({
    required String name,
    String? phone,
  });
  Future<Either<Failure, User>> uploadAvatar(File avatarFile);
  Future<Either<Failure, List<StylePreference>>> getStylePreferences();
  Future<Either<Failure, void>> updateStylePreferences(
      List<String> preferenceIds);
}
