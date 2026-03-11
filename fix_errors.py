import re

# Fix model imports in repository files
fixes = [
    (
        "lib/features/ai_try_on/data/repositories/ai_try_on_repository_impl.dart",
        [
            "import '../../domain/entities/try_on_result.dart';",
            "import '../models/try_on_result_model.dart';\nimport '../../domain/entities/try_on_result.dart';"
        ]
    ),
    (
        "lib/features/cart/data/repositories/cart_repository_impl.dart",
        [
            "import '../../domain/entities/cart.dart';",
            "import '../models/cart_model.dart';\nimport '../models/cart_item_model.dart';\nimport '../../domain/entities/cart.dart';"
        ]
    ),
    (
        "lib/features/checkout/data/repositories/checkout_repository_impl.dart",
        [
            "import '../../domain/entities/placed_order.dart';",
            "import '../models/shipping_address_model.dart';\nimport '../models/shipping_option_model.dart';\nimport '../models/placed_order_model.dart';\nimport '../../domain/entities/placed_order.dart';"
        ]
    ),
    (
        "lib/features/orders/data/repositories/orders_repository_impl.dart",
        [
            "import '../../domain/entities/order_summary.dart';",
            "import '../models/order_summary_model.dart';\nimport '../models/order_detail_model.dart';\nimport '../../domain/entities/order_summary.dart';"
        ]
    ),
    (
        "lib/features/product/data/repositories/product_repository_impl.dart",
        [
            "import '../../domain/entities/product.dart';",
            "import '../models/product_model.dart';\nimport '../models/review_model.dart';\nimport '../../domain/entities/product.dart';"
        ]
    ),
    (
        "lib/features/profile/data/repositories/profile_repository_impl.dart",
        [
            "import '../../domain/entities/style_preference.dart';",
            "import '../models/style_preference_model.dart';\nimport '../../domain/entities/style_preference.dart';"
        ]
    ),
    (
        "lib/features/home/presentation/pages/home_page.dart",
        [
            "categories: state.categories,",
            "categories: state.categories.cast<Category>(),"
        ],
        [
            "products: state.featuredProducts,",
            "products: state.featuredProducts.cast<ProductSummary>(),"
        ]
    ),
    (
        "lib/features/home/presentation/widgets/banner_carousel.dart",
        [
            "import '../domain/entities/banner.dart';",
            "import '../domain/entities/banner.dart' as entity;"
        ],
        [
            "final List<Banner> banners;",
            "final List<entity.Banner> banners;"
        ],
        [
            "const BannerCarousel({",
            "const BannerCarousel({"
        ]
    )
]

for item in fixes:
    path = item[0]
    with open(path, "r") as f:
        content = f.read()
    
    for i in range(1, len(item)):
        old_str, new_str = item[i]
        content = content.replace(old_str, new_str)
        
    # specific fix for banner_carousel
    if "banner_carousel" in path:
        content = content.replace("List<Banner>", "List<entity.Banner>")
        content = content.replace("final banner =", "final entity.Banner banner =")
        
    with open(path, "w") as f:
        f.write(content)

