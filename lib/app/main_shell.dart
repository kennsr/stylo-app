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
    label: 'Beranda',
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
        duration: const Duration(milliseconds: 400),
      ),
    );

    // Spring-like bounce: up → overshoot back → settle
    _scaleAnims = _scaleControllers.map((ctrl) {
      return TweenSequence<double>([
        TweenSequenceItem(
          tween: Tween(begin: 1.0, end: 1.32),
          weight: 28,
        ),
        TweenSequenceItem(
          tween: Tween(begin: 1.32, end: 0.88),
          weight: 30,
        ),
        TweenSequenceItem(
          tween: Tween(begin: 0.88, end: 1.0),
          weight: 42,
        ),
      ]).animate(CurvedAnimation(parent: ctrl, curve: Curves.easeInOut));
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
        color: context.backgroundColor,
        border: Border(
          top: BorderSide(color: context.dividerColor, width: 1),
        ),
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 64,
          child: Row(
            children: List.generate(_kTabs.length, (index) {
              final tab = _kTabs[index];
              final isActive = index == currentIndex;
              final badge = (index == 2 && cartCount > 0) ? cartCount : null;

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
    final color = isActive ? AppColors.accent : context.secondaryTextColor;

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        height: 64,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Animated icon with pill background
            ScaleTransition(
              scale: scaleAnim,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 260),
                curve: Curves.easeOut,
                width: isActive ? 46 : 28,
                height: 28,
                decoration: BoxDecoration(
                  color: isActive
                      ? AppColors.accent.withValues(alpha: 0.12)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Center(child: _buildIcon(color)),
              ),
            ),
            const SizedBox(height: 3),
            // Animated label
            AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 200),
              style: GoogleFonts.poppins(
                fontSize: 10,
                fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
                color: color,
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
      size: 22,
      color: color,
    );

    if (badge != null) {
      return Badge(
        label: Text('$badge'),
        child: icon,
      );
    }
    return icon;
  }
}
