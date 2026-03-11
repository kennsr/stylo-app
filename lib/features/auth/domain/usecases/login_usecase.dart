import 'package:equatable/equatable.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/utils/either.dart';
import '../../../../core/utils/usecase.dart';
import '../entities/user.dart';
import '../repositories/auth_repository.dart';

class LoginUseCase extends UseCase<User, LoginParams> {
  final AuthRepository repository;
  LoginUseCase(this.repository);

  @override
  Future<Either<Failure, User>> call(LoginParams params) =>
      repository.login(email: params.email, password: params.password);
}

class LoginParams extends Equatable {
  final String email;
  final String password;
   const LoginParams({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}
