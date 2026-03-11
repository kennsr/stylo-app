import 'package:equatable/equatable.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/utils/either.dart';
import '../../../../core/utils/usecase.dart';
import '../../../../features/auth/domain/entities/user.dart';
import '../repositories/profile_repository.dart';

class UpdateProfileUseCase implements UseCase<User, UpdateProfileParams> {
  final ProfileRepository repository;

  UpdateProfileUseCase(this.repository);

  @override
  Future<Either<Failure, User>> call(UpdateProfileParams params) {
    return repository.updateProfile(
      name: params.name,
      phone: params.phone,
    );
  }
}

class UpdateProfileParams extends Equatable {
  final String name;
  final String? phone;

   const UpdateProfileParams({required this.name, this.phone});

  @override
  List<Object?> get props => [name, phone];
}
