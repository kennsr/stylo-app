import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'di/injection_container.dart' as di;
import 'main_shell.dart';

// Core
import '../core/theme/app_theme.dart';
import '../core/theme/theme_cubit.dart';
import '../core/widgets/keyboard_dismiss_bar.dart';

// Auth
import '../features/auth/presentation/bloc/auth_bloc.dart';
import '../features/auth/presentation/bloc/auth_event.dart';
import '../features/auth/presentation/bloc/auth_state.dart';
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
import '../features/orders/presentation/bloc/order_detail_bloc.dart';
import '../features/orders/presentation/pages/orders_page.dart';
import '../features/orders/presentation/pages/order_detail_page.dart';

// Notifications
import '../features/notifications/presentation/bloc/notifications_bloc.dart';
import '../features/notifications/presentation/bloc/notifications_event.dart';
import '../features/notifications/presentation/pages/notifications_page.dart';

// Wishlist
import '../features/wishlist/presentation/bloc/wishlist_bloc.dart';
import '../features/wishlist/presentation/bloc/wishlist_event.dart';
import '../features/wishlist/presentation/pages/wishlist_page.dart';

// Profile
import '../features/profile/presentation/bloc/profile_bloc.dart';
import '../features/profile/presentation/pages/profile_page.dart';
import '../features/profile/presentation/pages/edit_profile_page.dart';

// Onboarding
import '../core/constants/app_constants.dart';
import '../features/onboarding/presentation/cubit/onboarding_cubit.dart';
import '../features/onboarding/presentation/pages/onboarding_page.dart';

// ── Auth router notifier ──────────────────────────────────────────────────────
// Bridges AuthBloc stream → GoRouter refreshListenable so the router
// re-evaluates its redirect whenever auth state changes.

class _AuthRouterNotifier extends ChangeNotifier {
  _AuthRouterNotifier(Stream<AuthState> stream) {
    _subscription = stream.listen((_) => notifyListeners());
  }

  late final StreamSubscription<AuthState> _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}

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

class StyloApp extends StatefulWidget {
  const StyloApp({super.key});

  @override
  State<StyloApp> createState() => _StyloAppState();
}

class _StyloAppState extends State<StyloApp> {
  late final AuthBloc _authBloc;
  late final _AuthRouterNotifier _routerNotifier;
  late final GoRouter _router;

  @override
  void initState() {
    super.initState();
    _authBloc = di.sl<AuthBloc>()..add(const AuthCheckStatus());
    _routerNotifier = _AuthRouterNotifier(_authBloc.stream);
    _router = _buildRouter();
  }

  @override
  void dispose() {
    _routerNotifier.dispose();
    _authBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>.value(value: _authBloc),
        BlocProvider<CartBloc>(
          create: (_) => di.sl<CartBloc>()..add(const CartFetch()),
        ),
        BlocProvider<WishlistBloc>(
          create: (_) => di.sl<WishlistBloc>()..add(const WishlistLoad()),
        ),
        BlocProvider<ThemeCubit>(
          create: (_) => di.sl<ThemeCubit>()..loadSavedTheme(),
        ),
      ],
      // React to auth state changes to keep cart & wishlist in sync with the
      // currently logged-in user.
      child: MultiBlocListener(
        listeners: [
          BlocListener<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is AuthAuthenticated) {
                // Re-fetch cart and wishlist for the newly authenticated user.
                context.read<CartBloc>().add(const CartFetch());
                context.read<WishlistBloc>().add(const WishlistLoad());
              } else if (state is AuthUnauthenticated) {
                // Clear cart and wishlist so previous user's data is not visible.
                context.read<CartBloc>().add(const CartClear());
                context.read<WishlistBloc>().add(const WishlistReset());
              }
            },
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
              routerConfig: _router,
              builder: (context, child) =>
                  KeyboardDismissBar(child: child!),
            );
          },
        ),
      ),
    );
  }

  GoRouter _buildRouter() {
    return GoRouter(
      initialLocation: '/splash',
      refreshListenable: _routerNotifier,
      redirect: (context, state) {
        final authState = _authBloc.state;
        final location = state.matchedLocation;
        final isOnSplash = location == '/splash';
        final isLoginFlow =
            location == '/login' || location == '/register';

        // While auth is loading, show splash — but if the user is already on
        // the login/register page (they tapped "Masuk"), stay there: those
        // pages show their own loading spinner inside the button.
        // Redirecting to /splash mid-login would mean an AuthError later
        // triggers the "on splash → /home" rule and silently skips auth.
        if (authState is AuthInitial || authState is AuthLoading) {
          if (isLoginFlow) return null;
          return isOnSplash ? null : '/splash';
        }

        // Confirmed unauthenticated (clean logout, no token, or app start
        // with no cached session). Guests can browse freely.
        if (authState is AuthUnauthenticated) {
          if (isOnSplash) return '/home'; // post-logout: land as guest
          if (isLoginFlow) return null;
          if (_requiresAuth(location)) return '/login';
          return null;
        }

        // Auth failed (wrong credentials, network error, expired token).
        // Always route to /login so the user can see the error and retry —
        // never to /home (that would log them in without a real session).
        if (authState is AuthError) {
          if (isOnSplash) return '/login';
          if (isLoginFlow) return null; // BlocConsumer on login page shows snackbar
          if (_requiresAuth(location)) return '/login';
          return null;
        }

        // Authenticated → check onboarding status first.
        if (authState is AuthAuthenticated) {
          final prefs = di.sl<SharedPreferences>();
          // Per-user key: each account gets its own onboarding flag so that
          // a second registration on the same device isn't skipped.
          final userId = authState.user.id;
          final onboardingDone =
              prefs.getBool('${AppConstants.onboardingKey}_$userId') ?? false;

          if (isOnSplash || isLoginFlow) {
            return onboardingDone ? '/home' : '/onboarding';
          }
          // Already on onboarding — allow if not done, redirect if done
          if (location == '/onboarding') {
            return onboardingDone ? '/home' : null;
          }
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

        // ── Onboarding (outside shell — no bottom nav) ────────────────────────
        GoRoute(
          path: '/onboarding',
          pageBuilder: (context, state) => _fadePage(
            state,
            BlocProvider(
              create: (_) => di.sl<OnboardingCubit>(),
              child: const OnboardingPage(),
            ),
          ),
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
                GoRoute(
                  path: '/notifications',
                  pageBuilder: (context, state) => _fadePage(
                    state,
                    BlocProvider(
                      create: (_) => di.sl<NotificationsBloc>()
                        ..add(const NotificationsFetch()),
                      child: const NotificationsPage(),
                    ),
                  ),
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
                          create: (_) => di.sl<OrderDetailBloc>(),
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
                // ShellRoute provides ONE ProfileBloc for every page in the
                // profile sub-tree.  GoRouter's ShellRoute wraps its inner
                // Navigator with the builder result, so /profile, /profile/edit,
                // and /profile/wishlist all sit inside the same BlocProvider.
                // This prevents ProviderNotFoundException, ensures the edit
                // form pre-fills with the already-loaded user, and makes a
                // successful save immediately visible back on the profile page.
                ShellRoute(
                  builder: (context, state, child) => BlocProvider(
                    create: (_) => di.sl<ProfileBloc>(),
                    child: child,
                  ),
                  routes: [
                    GoRoute(
                      path: '/profile',
                      pageBuilder: (context, state) =>
                          _fadePage(state, const ProfilePage()),
                      routes: [
                        GoRoute(
                          path: 'edit',
                          pageBuilder: (context, state) =>
                              _fadePage(state, const EditProfilePage()),
                        ),
                        GoRoute(
                          path: 'wishlist',
                          pageBuilder: (context, state) =>
                              _fadePage(state, const WishlistPage()),
                        ),
                      ],
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

  /// Routes that require the user to be authenticated.
  /// Guests can browse home, search, and product pages freely.
  bool _requiresAuth(String location) {
    const protectedPrefixes = [
      '/cart',
      '/checkout',
      '/try-on',
      '/orders',
      '/profile',
      '/onboarding',
    ];
    return protectedPrefixes.any((prefix) => location.startsWith(prefix));
  }
}
