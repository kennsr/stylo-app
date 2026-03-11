import re

with open("lib/app/di/injection_container.dart", "r") as f:
    content = f.read()

# Fix named parameters in Repositories
content = content.replace(
    "sl.registerLazySingleton<OrdersRepository>(() => OrdersRepositoryImpl(\n        remoteDataSource: sl(),\n        networkInfo: sl(),\n      ));",
    "sl.registerLazySingleton<OrdersRepository>(() => OrdersRepositoryImpl(\n        remoteDataSource: sl(),\n      ));"
)
content = content.replace(
    "sl.registerLazySingleton<ProfileRepository>(() => ProfileRepositoryImpl(\n        remoteDataSource: sl(),\n        networkInfo: sl(),\n      ));",
    "sl.registerLazySingleton<ProfileRepository>(() => ProfileRepositoryImpl(\n        remoteDataSource: sl(),\n      ));"
)

# Fix UseCase initializations (they expect repository: sl())
use_cases = [
    "LoginUseCase", "RegisterUseCase", "LogoutUseCase", "GetCurrentUserUseCase",
    "GetBannersUseCase", "GetCategoriesUseCase", "GetFeaturedProductsUseCase",
    "GetProductsUseCase", "GetProductDetailUseCase", "SearchProductsUseCase", "GetReviewsUseCase",
    "GenerateTryOnUseCase", "GetTryOnHistoryUseCase", "GetFitProfileUseCase", "SaveFitProfileUseCase",
    "GetCartUseCase", "AddToCartUseCase", "RemoveFromCartUseCase", "UpdateCartQuantityUseCase", "ClearCartUseCase",
    "GetAddressesUseCase", "GetShippingOptionsUseCase", "PlaceOrderUseCase",
    "GetOrdersUseCase", "GetOrderDetailUseCase",
    "GetProfileUseCase", "UpdateProfileUseCase", "GetStylePreferencesUseCase", "UpdateStylePreferencesUseCase"
]
for uc in use_cases:
    content = content.replace(f"() => {uc}(sl())", f"() => {uc}(repository: sl())")

# Fix undefined bloc parameters
content = content.replace(
    "searchProductsUseCase: sl(),\n      ))",
    "      ))"
)
content = content.replace(
    "getFitProfileUseCase: sl(),\n        saveFitProfileUseCase: sl(),\n      ))",
    "      ))"
)
content = content.replace(
    "getOrderDetailUseCase: sl(),\n      ))",
    "      ))"
)

with open("lib/app/di/injection_container.dart", "w") as f:
    f.write(content)
