import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../../../core/utils/either.dart';
import '../models/cart_model.dart';
import '../models/cart_item_model.dart';
import '../../domain/entities/cart.dart';
import '../../domain/entities/cart_item.dart';
import '../../domain/repositories/cart_repository.dart';
import '../datasources/cart_local_data_source.dart';
import '../datasources/cart_remote_data_source.dart';

class CartRepositoryImpl implements CartRepository {
  final CartRemoteDataSource remoteDataSource;
  final CartLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  CartRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, Cart>> getCart() async {
    final isConnected = await networkInfo.isConnected;
    if (isConnected) {
      try {
        final remoteCart = await remoteDataSource.getCart();
        await localDataSource.saveCart(remoteCart);
        return Right(remoteCart.toEntity());
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message));
      } on AuthException catch (e) {
        return Left(AuthFailure(message: e.message));
      } catch (e) {
        return Left(ServerFailure(message: e.toString()));
      }
    } else {
      try {
        final localCart = await localDataSource.getCart();
        if (localCart != null) {
          return Right(localCart.toEntity());
        }
        return  Right(Cart());
      } on CacheException catch (e) {
        return Left(CacheFailure(message: e.message));
      }
    }
  }

  @override
  Future<Either<Failure, Cart>> addToCart(CartItem item) async {
    final isConnected = await networkInfo.isConnected;
    if (isConnected) {
      try {
        final itemModel = item.toModel();
        final remoteCart = await remoteDataSource.addItem(itemModel);
        await localDataSource.saveCart(remoteCart);
        return Right(remoteCart.toEntity());
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message));
      } on AuthException catch (e) {
        return Left(AuthFailure(message: e.message));
      } catch (e) {
        return Left(ServerFailure(message: e.toString()));
      }
    } else {
      try {
        final localCart = await localDataSource.getCart() ??  CartModel();
        final existingIndex = localCart.items
            .indexWhere((i) => i.id == item.id || i.productId == item.productId);
        List updatedItems;
        if (existingIndex >= 0) {
          updatedItems = localCart.items.map((i) {
            if (i.productId == item.productId &&
                i.size == item.size &&
                i.color == item.color) {
              return i.copyWith(quantity: i.quantity + item.quantity);
            }
            return i;
          }).toList();
        } else {
          updatedItems = [...localCart.items, item.toModel()];
        }
        final updatedCart = CartModel(items: List.from(updatedItems));
        await localDataSource.saveCart(updatedCart);
        return Right(updatedCart.toEntity());
      } on CacheException catch (e) {
        return Left(CacheFailure(message: e.message));
      }
    }
  }

  @override
  Future<Either<Failure, Cart>> removeFromCart(String cartItemId) async {
    final isConnected = await networkInfo.isConnected;
    if (isConnected) {
      try {
        final remoteCart = await remoteDataSource.removeItem(cartItemId);
        await localDataSource.saveCart(remoteCart);
        return Right(remoteCart.toEntity());
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message));
      } on AuthException catch (e) {
        return Left(AuthFailure(message: e.message));
      } catch (e) {
        return Left(ServerFailure(message: e.toString()));
      }
    } else {
      try {
        final localCart = await localDataSource.getCart() ??  CartModel();
        final updatedItems =
            localCart.items.where((i) => i.id != cartItemId).toList();
        final updatedCart = CartModel(items: updatedItems);
        await localDataSource.saveCart(updatedCart);
        return Right(updatedCart.toEntity());
      } on CacheException catch (e) {
        return Left(CacheFailure(message: e.message));
      }
    }
  }

  @override
  Future<Either<Failure, Cart>> updateQuantity(
      String cartItemId, int quantity) async {
    final isConnected = await networkInfo.isConnected;
    if (isConnected) {
      try {
        final remoteCart =
            await remoteDataSource.updateItem(cartItemId, quantity);
        await localDataSource.saveCart(remoteCart);
        return Right(remoteCart.toEntity());
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message));
      } on AuthException catch (e) {
        return Left(AuthFailure(message: e.message));
      } catch (e) {
        return Left(ServerFailure(message: e.toString()));
      }
    } else {
      try {
        final localCart = await localDataSource.getCart() ??  CartModel();
        final updatedItems = localCart.items.map((i) {
          if (i.id == cartItemId) {
            return i.copyWith(quantity: quantity);
          }
          return i;
        }).toList();
        final updatedCart = CartModel(items: updatedItems);
        await localDataSource.saveCart(updatedCart);
        return Right(updatedCart.toEntity());
      } on CacheException catch (e) {
        return Left(CacheFailure(message: e.message));
      }
    }
  }

  @override
  Future<Either<Failure, void>> clearCart() async {
    try {
      await localDataSource.clearCart();
      return  Right(null);
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    }
  }
}
