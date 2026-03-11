import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'di/injection_container.dart' as di;
import 'main_shell.dart';

// Core
import '../core/theme/app_theme.dart';
import '../core/theme/theme_cubit.dart';
import '../core/widgets/keyboard_dismiss_bar.dart';

// Auth
import '../features/auth/presentation/bloc/auth_bloc.dart';
import '../features/auth/presentation/bloc/auth_event.dart';
import '../features/auth/presentation/pages/splash_page.dart';
import '../features/auth/presentation/pages/login_page.dart';
import '../features/auth/presentation/pages/register_page.dart';

// Home
import '../features/home/presentation/bloc/home_bloc.dart';
import '../features/home/presentation/pages/home_page.dart';

// Product
import '../features/product/presentation/bloc/product_list_bloc.dart';
import '../features/product/presentation/bloc/product_detail_bloc.dart';
import '../features/product/presentation/pages/product_list_page.dart';
import '../features/product/presentation/pages/product_detail_page.dart';
import '../features/product/presentation/pages/search_page.dart';

// AI Try-On
import '../features/ai_try_on/presentation/bloc/ai_try_on_bloc.dart';
import '../features/ai_try_on/presentation/pages/ai_try_on_page.dart';
import '../features/ai_try_on/presentation/pages/fit_profile_page.dart';

// Cart
import '../features/cart/presentation/bloc/cart_bloc.dart';
import '../features/cart/presentation/bloc/cart_event.dart';
import '../features/cart/presentation/pages/cart_page.dart';

// Checkout
import '../features/checkout/presentation/bloc/checkout_bloc.dart';
import '../features/checkout/presentation/pages/checkout_page.dart';
import '../features/checkout/presentation/pages/order_success_page.dart';
import '../features/checkout/domain/entities/placed_order.dart';

// Orders
import '../features/orders/presentation/bloc/orders_bloc.dart';
import '../features/orders/presentation/pages/orders_page.dart';
import '../features/orders/presentation/pages/order_detail_page.dart';

// Profile
import '../features/profile/presentation/bloc/profile_bloc.dart';
import '../features/profile/presentation/pages/profile_page.dart';
import '../features/profile/presentation/pages/edit_profile_page.dart';

// ── Fade transition helper ────────────────────────────────────────────────────

Page<void> _fadePage(GoRouterState state, Widget child) {
  return CustomTransitionPage<void>(
    key: state.pageKey,
    child: child,
    transitionDuration: const Duration(milliseconds: 280),
    reverseTransitionDuration: const Duration(milliseconds: 200),
    transitionsBuilder: (_, animation, _, child) => FadeTransition(
      opacity: CurvedAnimation(parent: animation, curve: Curves.easeOut),
      child: child,
    ),
  );
}

// ── App ───────────────────────────────────────────────────────────────────────

class StyloApp extends StatelessWidget {
  const StyloApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (_) => di.sl<AuthBloc>()..add(const AuthCheckStatus()),
        ),
        BlocProvider<CartBloc>(
          create: (_) => di.sl<CartBloc>()..add(const CartFetch()),
        ),
        BlocProvider<ThemeCubit>(
          create: (_) => di.sl<ThemeCubit>()..loadSavedTheme(),
        ),
      ],
      child: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (context, themeMode) {
          return MaterialApp.router(
            title: 'Stylo',
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: themeMode,
            routerConfig: _buildRouter(),
            builder: (context, child) =>
                KeyboardDismissBar(child: child!),
          );
        },
      ),
    );
  }

  GoRouter _buildRouter() {
    return GoRouter(
      initialLocation: '/splash',
      redirect: (context, state) {
        final location = state.matchedLocation;
        if (location == '/splash' ||
            location == '/login' ||
            location == '/register') {
          return null;
        }
        return null;
      },
      routes: [
        // ── Auth ──────────────────────────────────────────────────────────────
        GoRoute(
          path: '/splash',
          pageBuilder: (context, state) => _fadePage(state, const SplashPage()),
        ),
        GoRoute(
          path: '/login',
          pageBuilder: (context, state) => _fadePage(state, const LoginPage()),
        ),
        GoRoute(
          path: '/register',
          pageBuilder: (context, state) =>
              _fadePage(state, const RegisterPage()),
        ),

        // ── Checkout (outside shell — no bottom nav) ──────────────────────────
        GoRoute(
          path: '/checkout',
          pageBuilder: (context, state) => _fadePage(
            state,
            BlocProvider(
              create: (_) => di.sl<CheckoutBloc>(),
              child: const CheckoutPage(),
            ),
          ),
          routes: [
            GoRoute(
              path: 'success',
              pageBuilder: (context, state) => _fadePage(
                state,
                OrderSuccessPage(order: state.extra as PlacedOrder),
              ),
            ),
          ],
        ),

        // ── Shell (with bottom nav) ───────────────────────────────────────────
        StatefulShellRoute.indexedStack(
          builder: (context, state, navigationShell) =>
              MainShell(navigationShell: navigationShell),
          branches: [
            // Beranda branch
            StatefulShellBranch(
              routes: [
                GoRoute(
                  path: '/home',
                  pageBuilder: (context, state) => _fadePage(
                    state,
                    BlocProvider(
                      create: (_) => di.sl<HomeBloc>(),
                      child: const HomePage(),
                    ),
                  ),
                ),
                GoRoute(
                  path: '/products',
                  pageBuilder: (context, state) => _fadePage(
                    state,
                    BlocProvider(
                      create: (_) => di.sl<ProductListBloc>(),
                      child: ProductListPage(
                        category: state.uri.queryParameters['category'],
                      ),
                    ),
                  ),
                  routes: [
                    GoRoute(
                      path: ':id',
                      pageBuilder: (context, state) => _fadePage(
                        state,
                        BlocProvider(
                          create: (_) => di.sl<ProductDetailBloc>(),
                          child: ProductDetailPage(
                            productId: state.pathParameters['id']!,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                GoRoute(
                  path: '/try-on',
                  pageBuilder: (context, state) => _fadePage(
                    state,
                    BlocProvider(
                      create: (_) => di.sl<AiTryOnBloc>(),
                      child: AiTryOnPage(
                        productId:
                            state.uri.queryParameters['productId'] ?? '',
                      ),
                    ),
                  ),
                  routes: [
                    GoRoute(
                      path: 'fit-profile',
                      pageBuilder: (context, state) =>
                          _fadePage(state, const FitProfilePage()),
                    ),
                  ],
                ),
              ],
            ),

            // Cari branch
            StatefulShellBranch(
              routes: [
                GoRoute(
                  path: '/search',
                  pageBuilder: (context, state) => _fadePage(
                    state,
                    BlocProvider(
                      create: (_) => di.sl<ProductListBloc>(),
                      child: const SearchPage(),
                    ),
                  ),
                ),
              ],
            ),

            // Keranjang branch
            StatefulShellBranch(
              routes: [
                GoRoute(
                  path: '/cart',
                  pageBuilder: (context, state) =>
                      _fadePage(state, const CartPage()),
                ),
              ],
            ),

            // Pesanan branch
            StatefulShellBranch(
              routes: [
                GoRoute(
                  path: '/orders',
                  pageBuilder: (context, state) => _fadePage(
                    state,
                    BlocProvider(
                      create: (_) => di.sl<OrdersBloc>(),
                      child: const OrdersPage(),
                    ),
                  ),
                  routes: [
                    GoRoute(
                      path: ':id',
                      pageBuilder: (context, state) => _fadePage(
                        state,
                        BlocProvider(
                          create: (_) => di.sl<OrdersBloc>(),
                          child: OrderDetailPage(
                            orderId: state.pathParameters['id']!,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),

            // Profil branch
            StatefulShellBranch(
              routes: [
                GoRoute(
                  path: '/profile',
                  pageBuilder: (context, state) => _fadePage(
                    state,
                    BlocProvider(
                      create: (_) => di.sl<ProfileBloc>(),
                      child: const ProfilePage(),
                    ),
                  ),
                  routes: [
                    GoRoute(
                      path: 'edit',
                      pageBuilder: (context, state) => _fadePage(
                        state,
                        BlocProvider(
                          create: (_) => di.sl<ProfileBloc>(),
                          child: const EditProfilePage(),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
