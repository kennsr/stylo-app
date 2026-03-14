import 'dart:io';

import '../../../../core/errors/failures.dart';
import '../../../../core/utils/either.dart';
import '../../../../core/utils/usecase.dart';
import '../../../auth/domain/entities/user.dart';
import '../repositories/profile_repository.dart';

class UploadAvatarUseCase implements UseCase<User, UploadAvatarParams> {
  final ProfileRepository repository;

  UploadAvatarUseCase(this.repository);

  @override
  Future<Either<Failure, User>> call(UploadAvatarParams params) {
    return repository.uploadAvatar(params.avatarFile);
  }
}

class UploadAvatarParams {
  final File avatarFile;

  const UploadAvatarParams({required this.avatarFile});
}
