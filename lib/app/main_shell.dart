import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../features/cart/presentation/bloc/cart_bloc.dart';
import '../features/cart/presentation/bloc/cart_state.dart';
import '../core/theme/app_colors.dart';
import '../core/theme/theme_ext.dart';

// ── Tab metadata ─────────────────────────────────────────────────────────────

class _TabData {
  final String label;
  final IconData icon;
  final IconData activeIcon;

  const _TabData({
    required this.label,
    required this.icon,
    required this.activeIcon,
  });
}

const List<_TabData> _kTabs = [
  _TabData(
    label: 'Home',
    icon: Icons.home_outlined,
    activeIcon: Icons.home_rounded,
  ),
  _TabData(
    label: 'Cari',
    icon: Icons.search_outlined,
    activeIcon: Icons.search_rounded,
  ),
  _TabData(
    label: 'Keranjang',
    icon: Icons.shopping_bag_outlined,
    activeIcon: Icons.shopping_bag_rounded,
  ),
  _TabData(
    label: 'Pesanan',
    icon: Icons.receipt_long_outlined,
    activeIcon: Icons.receipt_long_rounded,
  ),
  _TabData(
    label: 'Profil',
    icon: Icons.person_outline_rounded,
    activeIcon: Icons.person_rounded,
  ),
];

// ── Shell ─────────────────────────────────────────────────────────────────────

class MainShell extends StatefulWidget {
  final StatefulNavigationShell navigationShell;

  const MainShell({super.key, required this.navigationShell});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> with TickerProviderStateMixin {
  late final List<AnimationController> _scaleControllers;
  late final List<Animation<double>> _scaleAnims;

  @override
  void initState() {
    super.initState();

    _scaleControllers = List.generate(
      _kTabs.length,
      (_) => AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 300),
      ),
    );

    // Smooth spring-like animation
    _scaleAnims = _scaleControllers.map((ctrl) {
      return TweenSequence<double>([
        TweenSequenceItem(
          tween: Tween(begin: 1.0, end: 1.2),
          weight: 30,
        ),
        TweenSequenceItem(
          tween: Tween(begin: 1.2, end: 0.95),
          weight: 35,
        ),
        TweenSequenceItem(
          tween: Tween(begin: 0.95, end: 1.0),
          weight: 35,
        ),
      ]).animate(CurvedAnimation(parent: ctrl, curve: Curves.easeInOutCubic));
    }).toList();
  }

  @override
  void dispose() {
    for (final ctrl in _scaleControllers) {
      ctrl.dispose();
    }
    super.dispose();
  }

  void _onTabTap(BuildContext context, int index) {
    if (index != widget.navigationShell.currentIndex) {
      _scaleControllers[index].forward(from: 0);
    }
    widget.navigationShell.goBranch(
      index,
      initialLocation: index == widget.navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.navigationShell,
      extendBody: false,
      bottomNavigationBar: BlocBuilder<CartBloc, CartState>(
        builder: (context, cartState) {
          final cartCount =
              cartState is CartLoaded ? cartState.cart.totalItems : 0;
          return _BottomNav(
            currentIndex: widget.navigationShell.currentIndex,
            cartCount: cartCount,
            scaleAnims: _scaleAnims,
            onTap: (index) => _onTabTap(context, index),
          );
        },
      ),
    );
  }
}

// ── Custom bottom nav ─────────────────────────────────────────────────────────

class _BottomNav extends StatelessWidget {
  final int currentIndex;
  final int cartCount;
  final List<Animation<double>> scaleAnims;
  final ValueChanged<int> onTap;

  const _BottomNav({
    required this.currentIndex,
    required this.cartCount,
    required this.scaleAnims,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.surfaceColor,
        border: Border(
          top: BorderSide(color: context.dividerColor, width: 1),
        ),
        boxShadow: [
          BoxShadow(
            color: context.shadowColor,
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 80,
          child: Row(
            children: List.generate(_kTabs.length, (index) {
              final tab = _kTabs[index];
              final isActive = index == currentIndex;
              final badge = (index == 1 && cartCount > 0) ? cartCount : null;

              return Expanded(
                child: _NavItem(
                  tab: tab,
                  isActive: isActive,
                  badge: badge,
                  scaleAnim: scaleAnims[index],
                  onTap: () => onTap(index),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}

// ── Single nav item ───────────────────────────────────────────────────────────

class _NavItem extends StatelessWidget {
  final _TabData tab;
  final bool isActive;
  final int? badge;
  final Animation<double> scaleAnim;
  final VoidCallback onTap;

  const _NavItem({
    required this.tab,
    required this.isActive,
    required this.badge,
    required this.scaleAnim,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final color = isActive ? AppColors.primary : context.tertiaryTextColor;

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        height: 80,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Stack to keep icon position stable during animation
            Stack(
              alignment: Alignment.center,
              children: [
                // Background pill (only visible when active)
                AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.easeOut,
                  width: isActive ? 56 : 0,
                  height: 32,
                  decoration: BoxDecoration(
                    gradient: isActive
                        ? const LinearGradient(
                            colors: [
                              AppColors.primaryGradientStart,
                              AppColors.primaryGradientEnd,
                            ],
                          )
                        : null,
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                // Icon (always centered)
                ScaleTransition(
                  scale: scaleAnim,
                  child: _buildIcon(color),
                ),
              ],
            ),
            const SizedBox(height: 4),
            // Animated label
            AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 200),
              style: GoogleFonts.poppins(
                fontSize: 11,
                fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
                color: isActive ? AppColors.primary : color,
                letterSpacing: -0.2,
              ),
              child: Text(tab.label),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIcon(Color color) {
    final icon = Icon(
      isActive ? tab.activeIcon : tab.icon,
      size: 24,
      color: color,
    );

    if (badge != null) {
      return Badge(
        label: Text('$badge'),
        backgroundColor: AppColors.badge,
        textColor: Colors.white,
        child: icon,
      );
    }
    return icon;
  }
}
