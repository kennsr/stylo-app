import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/utils/either.dart';
import '../models/shipping_address_model.dart';
import '../models/shipping_option_model.dart';
import '../models/placed_order_model.dart';
import '../../domain/entities/placed_order.dart';
import '../../domain/entities/shipping_address.dart';
import '../../domain/entities/shipping_option.dart';
import '../../domain/repositories/checkout_repository.dart';
import '../datasources/checkout_remote_data_source.dart';

class CheckoutRepositoryImpl implements CheckoutRepository {
  final CheckoutRemoteDataSource remoteDataSource;

  CheckoutRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<ShippingAddress>>> getAddresses() async {
    try {
      final models = await remoteDataSource.getAddresses();
      return Right(models.map((m) => m.toEntity()).toList());
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on AuthException catch (e) {
      return Left(AuthFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<ShippingOption>>> getShippingOptions({
    required String addressId,
    required double weight,
  }) async {
    try {
      final models = await remoteDataSource.getShippingOptions(
        addressId: addressId,
        weight: weight,
      );
      return Right(models.map((m) => m.toEntity()).toList());
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on AuthException catch (e) {
      return Left(AuthFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, PlacedOrder>> placeOrder({
    required String addressId,
    required String shippingOptionId,
    required String paymentMethod,
  }) async {
    try {
      final model = await remoteDataSource.placeOrder(
        addressId: addressId,
        shippingOptionId: shippingOptionId,
        paymentMethod: paymentMethod,
      );
      return Right(model.toEntity());
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on AuthException catch (e) {
      return Left(AuthFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
