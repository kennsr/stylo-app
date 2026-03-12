import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

// Core
import '../../core/constants/app_constants.dart';
import '../../core/constants/env_config.dart';
import '../../core/network/api_client.dart';
import '../../core/network/network_info.dart';
import '../../core/theme/theme_cubit.dart';

// Auth
import '../../features/auth/data/datasources/auth_local_data_source.dart';
import '../../features/auth/data/datasources/auth_remote_data_source.dart';
import '../../features/auth/data/repositories/auth_repository_impl.dart';
import '../../features/auth/domain/repositories/auth_repository.dart';
import '../../features/auth/domain/usecases/login_usecase.dart';
import '../../features/auth/domain/usecases/register_usecase.dart';
import '../../features/auth/domain/usecases/logout_usecase.dart';
import '../../features/auth/domain/usecases/get_current_user_usecase.dart';
import '../../features/auth/presentation/bloc/auth_bloc.dart';

// Home
import '../../features/home/data/datasources/home_remote_data_source.dart';
import '../../features/home/data/repositories/home_repository_impl.dart';
import '../../features/home/domain/repositories/home_repository.dart';
import '../../features/home/domain/usecases/get_banners_usecase.dart';
import '../../features/home/domain/usecases/get_categories_usecase.dart';
import '../../features/home/domain/usecases/get_featured_products_usecase.dart';
import '../../features/home/presentation/bloc/home_bloc.dart';

// Product
import '../../features/product/data/datasources/product_remote_data_source.dart';
import '../../features/product/data/repositories/product_repository_impl.dart';
import '../../features/product/domain/repositories/product_repository.dart';
import '../../features/product/domain/usecases/get_products_usecase.dart';
import '../../features/product/domain/usecases/get_product_detail_usecase.dart';
import '../../features/product/domain/usecases/search_products_usecase.dart';
import '../../features/product/domain/usecases/get_reviews_usecase.dart';
import '../../features/product/presentation/bloc/product_list_bloc.dart';
import '../../features/product/presentation/bloc/product_detail_bloc.dart';

// AI Try-On
import '../../features/ai_try_on/data/datasources/ai_try_on_remote_data_source.dart';
import '../../features/ai_try_on/data/repositories/ai_try_on_repository_impl.dart';
import '../../features/ai_try_on/domain/repositories/ai_try_on_repository.dart';
import '../../features/ai_try_on/domain/usecases/generate_try_on_usecase.dart';
import '../../features/ai_try_on/domain/usecases/get_avatars_usecase.dart';
import '../../features/ai_try_on/domain/usecases/get_try_on_history_usecase.dart';
import '../../features/ai_try_on/domain/usecases/get_fit_profile_usecase.dart';
import '../../features/ai_try_on/domain/usecases/save_fit_profile_usecase.dart';
import '../../features/ai_try_on/presentation/bloc/ai_try_on_bloc.dart';

// Cart
import '../../features/cart/data/datasources/cart_local_data_source.dart';
import '../../features/cart/data/datasources/cart_remote_data_source.dart';
import '../../features/cart/data/repositories/cart_repository_impl.dart';
import '../../features/cart/domain/repositories/cart_repository.dart';
import '../../features/cart/domain/usecases/get_cart_usecase.dart';
import '../../features/cart/domain/usecases/add_to_cart_usecase.dart';
import '../../features/cart/domain/usecases/remove_from_cart_usecase.dart';
import '../../features/cart/domain/usecases/update_cart_quantity_usecase.dart';
import '../../features/cart/domain/usecases/clear_cart_usecase.dart';
import '../../features/cart/presentation/bloc/cart_bloc.dart';

// Checkout
import '../../features/checkout/data/datasources/checkout_remote_data_source.dart';
import '../../features/checkout/data/repositories/checkout_repository_impl.dart';
import '../../features/checkout/domain/repositories/checkout_repository.dart';
import '../../features/checkout/domain/usecases/get_addresses_usecase.dart';
import '../../features/checkout/domain/usecases/get_payment_methods_usecase.dart';
import '../../features/checkout/domain/usecases/get_shipping_options_usecase.dart';
import '../../features/checkout/domain/usecases/place_order_usecase.dart';
import '../../features/checkout/presentation/bloc/checkout_bloc.dart';

// Orders
import '../../features/orders/data/datasources/orders_remote_data_source.dart';
import '../../features/orders/data/repositories/orders_repository_impl.dart';
import '../../features/orders/domain/repositories/orders_repository.dart';
import '../../features/orders/domain/usecases/get_orders_usecase.dart';
import '../../features/orders/domain/usecases/get_order_detail_usecase.dart';
import '../../features/orders/presentation/bloc/orders_bloc.dart';
import '../../features/orders/presentation/bloc/order_detail_bloc.dart';

// Notifications
import '../../features/notifications/data/datasources/notifications_remote_data_source.dart';
import '../../features/notifications/data/repositories/notifications_repository_impl.dart';
import '../../features/notifications/domain/repositories/notifications_repository.dart';
import '../../features/notifications/domain/usecases/get_notifications_usecase.dart';
import '../../features/notifications/domain/usecases/mark_as_read_usecase.dart';
import '../../features/notifications/domain/usecases/mark_all_as_read_usecase.dart';
import '../../features/notifications/presentation/bloc/notifications_bloc.dart';

// Wishlist
import '../../features/wishlist/data/datasources/wishlist_local_data_source.dart';
import '../../features/wishlist/data/datasources/wishlist_remote_data_source.dart';
import '../../features/wishlist/data/repositories/wishlist_repository_impl.dart';
import '../../features/wishlist/domain/repositories/wishlist_repository.dart';
import '../../features/wishlist/domain/usecases/get_wishlist_usecase.dart';
import '../../features/wishlist/domain/usecases/toggle_wishlist_usecase.dart';
import '../../features/wishlist/presentation/bloc/wishlist_bloc.dart';

// Profile
import '../../features/profile/data/datasources/profile_remote_data_source.dart';
import '../../features/profile/data/repositories/profile_repository_impl.dart';
import '../../features/profile/domain/repositories/profile_repository.dart';
import '../../features/profile/domain/usecases/get_profile_usecase.dart';
import '../../features/profile/domain/usecases/update_profile_usecase.dart';
import '../../features/profile/domain/usecases/get_style_preferences_usecase.dart';
import '../../features/profile/domain/usecases/update_style_preferences_usecase.dart';
import '../../features/profile/presentation/bloc/profile_bloc.dart';

final sl = GetIt.instance;

/// SharedPreferences key that tracks which environment last wrote session data.
const _kLastEnvKey = 'stylo_last_env';

Future<void> init() async {
  // ─── External ───────────────────────────────────────────────────────────────
  final prefs = await SharedPreferences.getInstance();

  // ─── Stale-cache guard ──────────────────────────────────────────────────────
  // When the environment changes (e.g. mock → dev, dev → staging), cached
  // tokens, user objects, cart data and wishlist items from the previous
  // environment must be removed.  Without this, a mock-mode session (with a
  // fake token and seeded cart) would be visible the first time the app runs in
  // a real environment, causing the user to appear logged-in as the mock
  // account and see mock cart items.
  final lastEnv = prefs.getString(_kLastEnvKey) ?? '';
  final currentEnv = EnvConfig.current.name;
  if (lastEnv != currentEnv) {
    await prefs.remove(AppConstants.tokenKey);    // auth token
    await prefs.remove(AppConstants.userKey);     // cached user object
    await prefs.remove('cached_cart');            // CartLocalDataSourceImpl key
    await prefs.remove('stylo_wishlist');         // WishlistLocalDataSourceImpl key
    await prefs.setString(_kLastEnvKey, currentEnv);
  }

  sl.registerLazySingleton<SharedPreferences>(() => prefs);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => Connectivity());

  // ─── Core ────────────────────────────────────────────────────────────────────
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
  sl.registerLazySingleton(() => ApiClient(httpClient: sl(), prefs: sl()));
  // ThemeCubit takes SharedPreferences (confirmed from theme_cubit.dart)
  sl.registerFactory(() => ThemeCubit(sl()));

  // ─── Auth ─────────────────────────────────────────────────────────────────
  sl.registerLazySingleton<AuthLocalDataSource>(
    () => AuthLocalDataSourceImpl(sl()),
  );
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(sl()),
  );
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
      networkInfo: sl(),
    ),
  );
  sl.registerLazySingleton(() => LoginUseCase(sl()));
  sl.registerLazySingleton(() => RegisterUseCase(sl()));
  sl.registerLazySingleton(() => LogoutUseCase(sl()));
  sl.registerLazySingleton(() => GetCurrentUserUseCase(sl()));
  sl.registerFactory(
    () => AuthBloc(
      loginUseCase: sl(),
      registerUseCase: sl(),
      logoutUseCase: sl(),
      getCurrentUserUseCase: sl(),
    ),
  );

  // ─── Home ─────────────────────────────────────────────────────────────────
  sl.registerLazySingleton<HomeRemoteDataSource>(
    () => HomeRemoteDataSourceImpl(sl()),
  );
  sl.registerLazySingleton<HomeRepository>(
    () => HomeRepositoryImpl(remoteDataSource: sl(), networkInfo: sl()),
  );
  sl.registerLazySingleton(() => GetBannersUseCase(sl()));
  sl.registerLazySingleton(() => GetCategoriesUseCase(sl()));
  sl.registerLazySingleton(() => GetFeaturedProductsUseCase(sl()));
  sl.registerFactory(
    () => HomeBloc(
      getBannersUseCase: sl(),
      getCategoriesUseCase: sl(),
      getFeaturedProductsUseCase: sl(),
    ),
  );

  // ─── Product ──────────────────────────────────────────────────────────────
  sl.registerLazySingleton<ProductRemoteDataSource>(
    () => ProductRemoteDataSourceImpl(apiClient: sl()),
  );
  sl.registerLazySingleton<ProductRepository>(
    () => ProductRepositoryImpl(remoteDataSource: sl(), networkInfo: sl()),
  );
  sl.registerLazySingleton(() => GetProductsUseCase(repository: sl()));
  sl.registerLazySingleton(() => GetProductDetailUseCase(repository: sl()));
  sl.registerLazySingleton(() => SearchProductsUseCase(repository: sl()));
  sl.registerLazySingleton(() => GetReviewsUseCase(repository: sl()));
  sl.registerFactory(() => ProductListBloc(getProductsUseCase: sl()));
  sl.registerFactory(
    () => ProductDetailBloc(
      getProductDetailUseCase: sl(),
      getReviewsUseCase: sl(),
    ),
  );

  // ─── AI Try-On ────────────────────────────────────────────────────────────
  sl.registerLazySingleton<AiTryOnRemoteDataSource>(
    () => AiTryOnRemoteDataSourceImpl(apiClient: sl()),
  );
  sl.registerLazySingleton<AiTryOnRepository>(
    () => AiTryOnRepositoryImpl(remoteDataSource: sl(), networkInfo: sl()),
  );
  sl.registerLazySingleton(() => GenerateTryOnUseCase(repository: sl()));
  sl.registerLazySingleton(() => GetTryOnHistoryUseCase(repository: sl()));
  sl.registerLazySingleton(() => GetFitProfileUseCase(repository: sl()));
  sl.registerLazySingleton(() => SaveFitProfileUseCase(repository: sl()));
  sl.registerLazySingleton(() => GetAvatarsUseCase(repository: sl()));
  sl.registerFactory(
    () => AiTryOnBloc(
      generateTryOnUseCase: sl(),
      getTryOnHistoryUseCase: sl(),
      getAvatarsUseCase: sl(),
    ),
  );

  // ─── Cart ─────────────────────────────────────────────────────────────────
  sl.registerLazySingleton<CartLocalDataSource>(
    () => CartLocalDataSourceImpl(prefs: sl()),
  );
  sl.registerLazySingleton<CartRemoteDataSource>(
    () => CartRemoteDataSourceImpl(apiClient: sl()),
  );
  sl.registerLazySingleton<CartRepository>(
    () => CartRepositoryImpl(
      localDataSource: sl(),
      remoteDataSource: sl(),
      networkInfo: sl(),
    ),
  );
  sl.registerLazySingleton(() => GetCartUseCase(sl()));
  sl.registerLazySingleton(() => AddToCartUseCase(sl()));
  sl.registerLazySingleton(() => RemoveFromCartUseCase(sl()));
  sl.registerLazySingleton(() => UpdateCartQuantityUseCase(sl()));
  sl.registerLazySingleton(() => ClearCartUseCase(sl()));
  sl.registerFactory(
    () => CartBloc(
      getCartUseCase: sl(),
      addToCartUseCase: sl(),
      removeFromCartUseCase: sl(),
      updateCartQuantityUseCase: sl(),
      clearCartUseCase: sl(),
    ),
  );

  // ─── Checkout ─────────────────────────────────────────────────────────────
  sl.registerLazySingleton<CheckoutRemoteDataSource>(
    () => CheckoutRemoteDataSourceImpl(apiClient: sl()),
  );
  sl.registerLazySingleton<CheckoutRepository>(
    () => CheckoutRepositoryImpl(remoteDataSource: sl()),
  );
  sl.registerLazySingleton(() => GetAddressesUseCase(sl()));
  sl.registerLazySingleton(() => GetPaymentMethodsUseCase(sl()));
  sl.registerLazySingleton(() => GetShippingOptionsUseCase(sl()));
  sl.registerLazySingleton(() => PlaceOrderUseCase(sl()));
  sl.registerFactory(
    () => CheckoutBloc(
      getAddressesUseCase: sl(),
      getShippingOptionsUseCase: sl(),
      getPaymentMethodsUseCase: sl(),
      placeOrderUseCase: sl(),
    ),
  );

  // ─── Orders ───────────────────────────────────────────────────────────────
  sl.registerLazySingleton<OrdersRemoteDataSource>(
    () => OrdersRemoteDataSourceImpl(apiClient: sl()),
  );
  sl.registerLazySingleton<OrdersRepository>(
    () => OrdersRepositoryImpl(remoteDataSource: sl()),
  );
  sl.registerLazySingleton(() => GetOrdersUseCase(sl()));
  sl.registerLazySingleton(() => GetOrderDetailUseCase(sl()));
  sl.registerFactory(() => OrdersBloc(getOrdersUseCase: sl()));
  sl.registerFactory(
    () => OrderDetailBloc(getOrderDetailUseCase: sl()),
  );

  // ─── Notifications ────────────────────────────────────────────────────────
  sl.registerLazySingleton<NotificationsRemoteDataSource>(
    () => NotificationsRemoteDataSourceImpl(apiClient: sl()),
  );
  sl.registerLazySingleton<NotificationsRepository>(
    () => NotificationsRepositoryImpl(remoteDataSource: sl(), networkInfo: sl()),
  );
  sl.registerLazySingleton(() => GetNotificationsUseCase(sl()));
  sl.registerLazySingleton(() => MarkAsReadUseCase(sl()));
  sl.registerLazySingleton(() => MarkAllAsReadUseCase(sl()));
  sl.registerFactory(
    () => NotificationsBloc(
      getNotificationsUseCase: sl(),
      markAsReadUseCase: sl(),
      markAllAsReadUseCase: sl(),
    ),
  );

  // ─── Wishlist ─────────────────────────────────────────────────────────────
  sl.registerLazySingleton<WishlistLocalDataSource>(
    () => WishlistLocalDataSourceImpl(prefs: sl()),
  );
  sl.registerLazySingleton<WishlistRemoteDataSource>(
    () => WishlistRemoteDataSourceImpl(apiClient: sl()),
  );
  sl.registerLazySingleton<WishlistRepository>(
    () => WishlistRepositoryImpl(
      localDataSource: sl(),
      remoteDataSource: sl(),
    ),
  );
  sl.registerLazySingleton(() => GetWishlistUseCase(sl()));
  sl.registerLazySingleton(() => ToggleWishlistUseCase(sl()));
  sl.registerLazySingleton(
    () => WishlistBloc(
      getWishlistUseCase: sl(),
      toggleWishlistUseCase: sl(),
    ),
  );

  // ─── Profile ──────────────────────────────────────────────────────────────
  sl.registerLazySingleton<ProfileRemoteDataSource>(
    () => ProfileRemoteDataSourceImpl(apiClient: sl()),
  );
  sl.registerLazySingleton<ProfileRepository>(
    () => ProfileRepositoryImpl(remoteDataSource: sl()),
  );
  sl.registerLazySingleton(() => GetProfileUseCase(sl()));
  sl.registerLazySingleton(() => UpdateProfileUseCase(sl()));
  sl.registerLazySingleton(() => GetStylePreferencesUseCase(sl()));
  sl.registerLazySingleton(() => UpdateStylePreferencesUseCase(sl()));
  sl.registerFactory(
    () => ProfileBloc(
      getProfileUseCase: sl(),
      updateProfileUseCase: sl(),
      getStylePreferencesUseCase: sl(),
      updateStylePreferencesUseCase: sl(),
    ),
  );
}
