# Stylo App — Build Checklist

> Generated: 2026-03-11
> Architecture: Flutter + Clean Architecture (BLoC · get_it · freezed · drift)

---

## ✅ Core Infrastructure
- [x] `core/constants/` — api_constants, app_constants, env_config
- [x] `core/errors/` — exceptions, failures
- [x] `core/network/` — api_client (Dio), network_info (connectivity_plus)
- [x] `core/theme/` — app_colors, app_text_styles, app_theme, theme_cubit
- [x] `core/utils/` — either, input_converter, usecase, validators
- [x] `core/widgets/` — cached_product_image, category_chip, error_view, price_tag, rating_stars, stylo_button, stylo_shimmer, stylo_text_field, stylo_try_on_toggle

---

## 🔐 Auth Feature
- [x] `domain/entities/` — user.dart, auth_token.dart
- [x] `domain/repositories/` — auth_repository.dart (abstract)
- [x] `domain/usecases/` — login_usecase, register_usecase, logout_usecase, get_current_user_usecase
- [x] `data/models/` — user_model.dart (freezed)
- [x] `data/datasources/` — auth_local_data_source.dart (SharedPreferences)
- [ ] `data/datasources/` — auth_remote_data_source.dart (Dio)
- [ ] `data/repositories/` — auth_repository_impl.dart
- [ ] `presentation/bloc/` — auth_bloc.dart, auth_event.dart, auth_state.dart
- [ ] `presentation/pages/` — splash_page.dart, login_page.dart, register_page.dart
- [ ] `presentation/widgets/` — social_login_button.dart, auth_header.dart

---

## 🏠 Home Feature
- [ ] `domain/entities/` — banner.dart, category.dart
- [ ] `domain/repositories/` — home_repository.dart (abstract)
- [ ] `domain/usecases/` — get_banners_usecase, get_featured_products_usecase, get_categories_usecase
- [ ] `data/models/` — banner_model.dart, category_model.dart
- [ ] `data/datasources/` — home_remote_data_source.dart, home_local_data_source.dart
- [ ] `data/repositories/` — home_repository_impl.dart
- [ ] `presentation/bloc/` — home_bloc.dart, home_event.dart, home_state.dart
- [ ] `presentation/pages/` — home_page.dart
- [ ] `presentation/widgets/` — banner_carousel.dart, category_row.dart, featured_products_grid.dart, home_search_bar.dart

---

## 👗 Product Feature
- [ ] `domain/entities/` — product.dart, product_variant.dart, review.dart
- [ ] `domain/repositories/` — product_repository.dart (abstract)
- [ ] `domain/usecases/` — get_products_usecase, get_product_detail_usecase, search_products_usecase, get_reviews_usecase
- [ ] `data/models/` — product_model.dart, product_variant_model.dart, review_model.dart
- [ ] `data/datasources/` — product_remote_data_source.dart, product_local_data_source.dart (drift)
- [ ] `data/repositories/` — product_repository_impl.dart
- [ ] `presentation/bloc/` — product_list_bloc, product_detail_bloc, search_bloc
- [ ] `presentation/pages/` — product_list_page.dart, product_detail_page.dart, search_page.dart
- [ ] `presentation/widgets/` — product_card.dart, product_image_gallery.dart, size_selector.dart, color_selector.dart, review_list.dart, add_to_cart_bar.dart

---

## 🤖 AI Try-On Feature
- [ ] `domain/entities/` — try_on_result.dart, fit_profile.dart
- [ ] `domain/repositories/` — ai_try_on_repository.dart (abstract)
- [ ] `domain/usecases/` — generate_try_on_usecase, save_try_on_result_usecase, get_fit_profile_usecase, save_fit_profile_usecase
- [ ] `data/models/` — try_on_result_model.dart, fit_profile_model.dart
- [ ] `data/datasources/` — ai_try_on_remote_data_source.dart, ai_try_on_local_data_source.dart
- [ ] `data/repositories/` — ai_try_on_repository_impl.dart
- [ ] `presentation/bloc/` — ai_try_on_bloc.dart, ai_try_on_event.dart, ai_try_on_state.dart
- [ ] `presentation/pages/` — ai_try_on_page.dart, fit_profile_page.dart
- [ ] `presentation/widgets/` — try_on_result_view.dart, photo_upload_widget.dart, side_by_side_comparison.dart, fit_measurements_form.dart

---

## 🛒 Cart Feature
- [ ] `domain/entities/` — cart.dart, cart_item.dart
- [ ] `domain/repositories/` — cart_repository.dart (abstract)
- [ ] `domain/usecases/` — get_cart_usecase, add_to_cart_usecase, remove_from_cart_usecase, update_cart_quantity_usecase, clear_cart_usecase
- [ ] `data/models/` — cart_model.dart, cart_item_model.dart
- [ ] `data/datasources/` — cart_local_data_source.dart (drift), cart_remote_data_source.dart
- [ ] `data/repositories/` — cart_repository_impl.dart
- [ ] `presentation/bloc/` — cart_bloc.dart, cart_event.dart, cart_state.dart
- [ ] `presentation/pages/` — cart_page.dart
- [ ] `presentation/widgets/` — cart_item_tile.dart, cart_summary.dart, empty_cart_view.dart

---

## 💳 Checkout Feature (Phase 1 MVP)
- [ ] `domain/entities/` — order.dart, shipping_address.dart, payment_method.dart, shipping_option.dart
- [ ] `domain/repositories/` — checkout_repository.dart (abstract)
- [ ] `domain/usecases/` — place_order_usecase, get_shipping_options_usecase, calculate_shipping_usecase
- [ ] `data/models/` — order_model.dart, shipping_address_model.dart, shipping_option_model.dart
- [ ] `data/datasources/` — checkout_remote_data_source.dart
- [ ] `data/repositories/` — checkout_repository_impl.dart
- [ ] `presentation/bloc/` — checkout_bloc.dart, checkout_event.dart, checkout_state.dart
- [ ] `presentation/pages/` — checkout_page.dart, order_success_page.dart
- [ ] `presentation/widgets/` — address_form.dart, payment_method_selector.dart, shipping_option_selector.dart, order_summary_tile.dart

---

## 📦 Orders Feature
- [ ] `domain/entities/` — order_summary.dart, order_detail.dart, order_item.dart
- [ ] `domain/repositories/` — orders_repository.dart (abstract)
- [ ] `domain/usecases/` — get_orders_usecase, get_order_detail_usecase, track_order_usecase
- [ ] `data/models/` — order_summary_model.dart, order_detail_model.dart
- [ ] `data/datasources/` — orders_remote_data_source.dart, orders_local_data_source.dart
- [ ] `data/repositories/` — orders_repository_impl.dart
- [ ] `presentation/bloc/` — orders_bloc.dart, orders_event.dart, orders_state.dart
- [ ] `presentation/pages/` — orders_page.dart, order_detail_page.dart
- [ ] `presentation/widgets/` — order_card.dart, order_status_badge.dart, order_timeline.dart

---

## 👤 Profile Feature
- [ ] `domain/entities/` — address.dart, style_preference.dart
- [ ] `domain/repositories/` — profile_repository.dart (abstract)
- [ ] `domain/usecases/` — get_profile_usecase, update_profile_usecase, get_addresses_usecase, add_address_usecase
- [ ] `data/models/` — profile_model.dart, address_model.dart
- [ ] `data/datasources/` — profile_remote_data_source.dart, profile_local_data_source.dart
- [ ] `data/repositories/` — profile_repository_impl.dart
- [ ] `presentation/bloc/` — profile_bloc.dart, profile_event.dart, profile_state.dart
- [ ] `presentation/pages/` — profile_page.dart, edit_profile_page.dart, addresses_page.dart
- [ ] `presentation/widgets/` — profile_header.dart, menu_tile.dart, style_preference_chips.dart

---

## 🧭 App-Level Wiring
- [ ] `app/app.dart` — GoRouter setup with auth guard, nested navigation, deep links
- [ ] `app/di/injection_container.dart` — Register all BLoCs, use cases, repos, data sources, external deps
- [ ] `main.dart` — Init DI, wrap with MultiBlocProvider + MaterialApp.router
- [ ] Bottom navigation shell (Home · Cart · AI Try-On · Profile)

---

## 🔧 Code Generation
- [ ] Run `dart run build_runner build --delete-conflicting-outputs`
- [ ] Verify all `.freezed.dart` and `.g.dart` files generated correctly

---

## 🧪 Tests (stretch goal)
- [ ] Unit tests for use cases
- [ ] Unit tests for repository implementations
- [ ] Widget tests for key pages (login, home, product detail)
