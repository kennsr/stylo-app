import '../../../../core/constants/env_config.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../../../core/utils/either.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_local_data_source.dart';
import '../datasources/auth_remote_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final AuthLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, User>> login({
    required String email,
    required String password,
  }) async {
    if (!await networkInfo.isConnected) {
      return Left(NetworkFailure());
    }
    try {
      final result = await remoteDataSource.login(
        email: email,
        password: password,
      );
      await localDataSource.cacheUser(result.user);
      // Cache session token with expiry (if backend provides it)
      // For now, we set a long expiry (30 days) - adjust based on your backend
      await localDataSource.cacheSessionToken(
        result.token,
        expiresAt: DateTime.now().add(const Duration(days: 30)),
      );
      return Right(result.user.toEntity());
    } on AuthException catch (e) {
      return Left(AuthFailure(message: e.message));
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message));
    } catch (e) {
      // Catches TypeError / FormatException from JSON parsing when the server
      // returns an unexpected shape (e.g. {"data": null} with a 200 status).
      return Left(ServerFailure(message: 'Email atau kata sandi salah'));
    }
  }

  @override
  Future<Either<Failure, User>> register({
    required String name,
    required String email,
    required String password,
  }) async {
    if (!await networkInfo.isConnected) {
      return Left(NetworkFailure());
    }
    try {
      final result = await remoteDataSource.register(
        name: name,
        email: email,
        password: password,
      );
      await localDataSource.cacheUser(result.user);
      // Cache session token with expiry (if backend provides it)
      await localDataSource.cacheSessionToken(
        result.token,
        expiresAt: DateTime.now().add(const Duration(days: 30)),
      );
      return Right(result.user.toEntity());
    } on AuthException catch (e) {
      return Left(AuthFailure(message: e.message));
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message));
    } catch (e) {
      // Catches TypeError / FormatException from unexpected server response shape.
      return Left(ServerFailure(message: 'Pendaftaran gagal, coba lagi'));
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    // Always clear local session first — logout must NEVER fail from the
    // user's perspective even if the server is unreachable or returns an error.
    await localDataSource.clearSession();
    try {
      if (await networkInfo.isConnected) {
        await remoteDataSource.logout(); // best-effort: invalidate token on server
      }
    } catch (_) {
      // Server logout failed (404, network error, etc.) — that's fine,
      // local cache is already cleared so the user is logged out locally.
    }
    return Right(null);
  }

  @override
  Future<Either<Failure, User>> getCurrentUser() async {
    try {
      if (!EnvConfig.useMock) {
        // In real environments: ALWAYS verify token with the server.
        // Never trust stale cache — it could be leftover from mock mode
        // or a previous session with an expired token.
        
        final token = await localDataSource.getSessionToken();
        
        // If no token, check legacy token for backward compatibility
        if (token == null || token.isEmpty) {
          final legacyToken = await localDataSource.getToken();
          if (legacyToken != null && legacyToken.isNotEmpty) {
            // Migrate to new session format
            await localDataSource.cacheSessionToken(
              legacyToken,
              expiresAt: DateTime.now().add(const Duration(days: 30)),
            );
            await localDataSource.cacheLastLoginTime(DateTime.now());
          } else {
            await localDataSource.clearSession();
            return Left(AuthFailure(message: 'Sesi tidak ditemukan, silakan login'));
          }
        }
        
        // Check session validity (token expiry and max age)
        // But be lenient - if we have a token, let the server decide if it's valid
        final sessionValid = await localDataSource.isSessionValid();
        if (!sessionValid) {
          // Don't clear session yet - let server validate
          // This allows users to complete onboarding even if session is slightly old
        }
        
        if (!await networkInfo.isConnected) {
          // Offline: fall back to cached user so the app still works
          final cachedUser = await localDataSource.getCachedUser();
          if (cachedUser != null) return Right(cachedUser.toEntity());
          return Left(NetworkFailure(message: 'Tidak ada koneksi internet'));
        }
        
        // Check if token needs refresh (approaching expiry)
        if (await localDataSource.shouldRefreshToken()) {
          if (await localDataSource.canRefreshToken()) {
            // Attempt to refresh token (if your backend supports it)
            // For now, just update the last refresh time to prevent rapid retries
            await localDataSource.cacheLastRefreshTime(DateTime.now());
          }
        }
        
        // Hit GET /auth/me — throws AuthException on 401 (invalid/expired token)
        final userModel = await remoteDataSource.getCurrentUser();
        await localDataSource.cacheUser(userModel);
        // Update session timestamp on successful validation
        await localDataSource.cacheLastLoginTime(DateTime.now());
        return Right(userModel.toEntity());
      }

      // Mock mode: trust cache (or fetch from mock endpoint)
      final cachedUser = await localDataSource.getCachedUser();
      if (cachedUser != null) return Right(cachedUser.toEntity());
      if (!await networkInfo.isConnected) return Left(NetworkFailure());
      final userModel = await remoteDataSource.getCurrentUser();
      await localDataSource.cacheUser(userModel);
      return Right(userModel.toEntity());
    } on AuthException catch (e) {
      // 401 from server → token is invalid, force re-login
      await localDataSource.clearSession();
      return Left(AuthFailure(message: e.message));
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message));
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    }
  }

  @override
  Future<bool> isLoggedIn() async {
    return localDataSource.isLoggedIn();
  }
}
