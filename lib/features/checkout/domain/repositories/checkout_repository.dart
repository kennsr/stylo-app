import '../../../../core/errors/failures.dart';
import '../../../../core/utils/either.dart';
import '../entities/placed_order.dart';
import '../entities/shipping_address.dart';
import '../entities/shipping_option.dart';

abstract class CheckoutRepository {
  Future<Either<Failure, List<ShippingAddress>>> getAddresses();
  Future<Either<Failure, List<ShippingOption>>> getShippingOptions({
    required String addressId,
    required double weight,
  });
  Future<Either<Failure, PlacedOrder>> placeOrder({
    required String addressId,
    required String shippingOptionId,
    required String paymentMethod,
  });
}
