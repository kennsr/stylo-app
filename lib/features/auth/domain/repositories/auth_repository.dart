import '../../../../core/utils/either.dart';
import '../../../../core/errors/failures.dart';
import '../entities/user.dart';

abstract class AuthRepository {
  Future<Either<Failure, User>> login({
    required String email,
    required String password,
  });
  Future<Either<Failure, User>> register({
    required String name,
    required String email,
    required String password,
  });
  Future<Either<Failure, void>> logout();
  Future<Either<Failure, User>> getCurrentUser();
  Future<bool> isLoggedIn();
}
