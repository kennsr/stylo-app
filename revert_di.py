with open("lib/app/di/injection_container.dart", "r") as f:
    content = f.read()

# Fix UseCase initializations back to positional (sl())
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
    content = content.replace(f"() => {uc}(repository: sl())", f"() => {uc}(sl())")

with open("lib/app/di/injection_container.dart", "w") as f:
    f.write(content)
