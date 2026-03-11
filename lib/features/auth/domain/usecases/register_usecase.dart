import 'package:equatable/equatable.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/utils/either.dart';
import '../../../../core/utils/usecase.dart';
import '../entities/user.dart';
import '../repositories/auth_repository.dart';

class RegisterUseCase extends UseCase<User, RegisterParams> {
  final AuthRepository repository;
  RegisterUseCase(this.repository);

  @override
  Future<Either<Failure, User>> call(RegisterParams params) =>
      repository.register(
          name: params.name, email: params.email, password: params.password);
}

class RegisterParams extends Equatable {
  final String name;
  final String email;
  final String password;
   const RegisterParams(
      {required this.name, required this.email, required this.password});

  @override
  List<Object> get props => [name, email, password];
}
