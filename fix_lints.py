import os

# 1. injection_container.dart - add networkInfo back
inj_path = "lib/app/di/injection_container.dart"
with open(inj_path, "r") as f:
    text = f.read()

text = text.replace(
    "sl.registerLazySingleton<ProductRepository>(() => ProductRepositoryImpl(\n        remoteDataSource: sl(),\n      ));",
    "sl.registerLazySingleton<ProductRepository>(() => ProductRepositoryImpl(\n        remoteDataSource: sl(),\n        networkInfo: sl(),\n      ));"
)
text = text.replace(
    "sl.registerLazySingleton<AiTryOnRepository>(() => AiTryOnRepositoryImpl(\n        remoteDataSource: sl(),\n      ));",
    "sl.registerLazySingleton<AiTryOnRepository>(() => AiTryOnRepositoryImpl(\n        remoteDataSource: sl(),\n        networkInfo: sl(),\n      ));"
)

with open(inj_path, "w") as f:
    f.write(text)

# 2. app.dart - import PlacedOrder
app_path = "lib/app/app.dart"
with open(app_path, "r") as f:
    app_text = f.read()

if "import '../features/checkout/domain/entities/placed_order.dart';" not in app_text:
    app_text = app_text.replace(
        "import '../features/checkout/presentation/pages/order_success_page.dart';",
        "import '../features/checkout/presentation/pages/order_success_page.dart';\nimport '../features/checkout/domain/entities/placed_order.dart';"
    )

with open(app_path, "w") as f:
    f.write(app_text)

# 3. auth_remote_data_source.dart - remove exceptions import if not used
auth_ds_path = "lib/features/auth/data/datasources/auth_remote_data_source.dart"
with open(auth_ds_path, "r") as f:
    lines = f.readlines()
with open(auth_ds_path, "w") as f:
    for line in lines:
        if "'../../../../core/errors/exceptions.dart'" not in line:
            f.write(line)

# 4. auth_repository_impl.dart - remove unused import
auth_repo_path = "lib/features/auth/data/repositories/auth_repository_impl.dart"
with open(auth_repo_path, "r") as f:
    lines = f.readlines()
with open(auth_repo_path, "w") as f:
    for line in lines:
        if "'../models/user_model.dart'" not in line:
            f.write(line)

# 5. cart_repository_impl.dart - remove duplicate import
cart_repo_path = "lib/features/cart/data/repositories/cart_repository_impl.dart"
with open(cart_repo_path, "r") as f:
    lines = f.readlines()
with open(cart_repo_path, "w") as f:
    seen = set()
    for line in lines:
        if line.startswith("import"):
            if line in seen:
                continue
            seen.add(line)
        f.write(line)

# 6. fit_profile_page.dart - unused profile variable
fit_path = "lib/features/ai_try_on/presentation/pages/fit_profile_page.dart"
with open(fit_path, "r") as f:
    lines = f.readlines()
with open(fit_path, "w") as f:
    for line in lines:
        if "final profile = state.profile;" in line:
            continue
        f.write(line)

# 7. photo_upload_widget.dart - restore _selectedPhotoBase64
photo_path = "lib/features/ai_try_on/presentation/widgets/photo_upload_widget.dart"
with open(photo_path, "r") as f:
    photo_text = f.read()

if "String? _selectedPhotoBase64;" not in photo_text:
    photo_text = photo_text.replace(
        "class _PhotoUploadWidgetState extends State<PhotoUploadWidget> {\n  bool _hasPhoto = false;",
        "class _PhotoUploadWidgetState extends State<PhotoUploadWidget> {\n  String? _selectedPhotoBase64;\n  bool _hasPhoto = false;"
    )

with open(photo_path, "w") as f:
    f.write(photo_text)

print("Fixes applied.")
