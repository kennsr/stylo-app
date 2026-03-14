import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/theme/app_colors.dart';
import '../bloc/cart_bloc.dart';
import '../bloc/cart_event.dart';
import '../bloc/cart_state.dart';
import '../widgets/cart_item_tile.dart';
import '../widgets/cart_summary.dart';
import '../widgets/empty_cart_view.dart';
import '../../../../core/theme/theme_ext.dart';

class CartPage extends StatefulWidget {
   const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.surfaceColor,
      appBar: AppBar(
        backgroundColor: context.backgroundColor,
        elevation: 0,
        scrolledUnderElevation: 0,
        automaticallyImplyLeading: false,
        title: BlocBuilder<CartBloc, CartState>(
          builder: (context, state) {
            final count = state is CartLoaded ? state.cart.totalItems : 0;
            return Text(
              count > 0 ? 'Keranjang ($count)' : 'Keranjang Belanja',
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: context.primaryTextColor,
              ),
            );
          },
        ),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize:  Size.fromHeight(1),
          child: Container(height: 1, color: context.dividerColor),
        ),
      ),
      body: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          if (state is CartLoading) {
            return const _CartShimmer();
          }

          if (state is CartError) {
            return Center(
              child: Padding(
                padding:  EdgeInsets.all(32),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        color: AppColors.error.withValues(alpha: 0.1),
                        shape: BoxShape.circle,
                      ),
                      child:  Icon(
                        Icons.error_outline,
                        size: 40,
                        color: AppColors.error,
                      ),
                    ),
                     SizedBox(height: 20),
                    Text(
                      state.message,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        color: context.secondaryTextColor,
                      ),
                    ),
                     SizedBox(height: 20),
                    OutlinedButton(
                      onPressed: () =>
                          context.read<CartBloc>().add( CartFetch()),
                      style: OutlinedButton.styleFrom(
                        side:  BorderSide(color: AppColors.accent),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding:  EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 12,
                        ),
                      ),
                      child: Text(
                        'Coba Lagi Dong',
                        style: GoogleFonts.poppins(
                          color: AppColors.accent,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }

          if (state is CartLoaded) {
            if (state.cart.items.isEmpty) {
              return  EmptyCartView();
            }

            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    padding:  EdgeInsets.symmetric(vertical: 8),
                    itemCount: state.cart.items.length,
                    itemBuilder: (context, index) {
                      return CartItemTile(item: state.cart.items[index]);
                    },
                  ),
                ),
                CartSummary(cart: state.cart),
              ],
            );
          }

          return  SizedBox.shrink();
        },
      ),
    );
  }
}

class _CartShimmer extends StatelessWidget {
  const _CartShimmer();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding:  EdgeInsets.symmetric(vertical: 8),
      itemCount: 3,
      itemBuilder: (_, _) => Container(
        margin:  EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        height: 112,
        decoration: BoxDecoration(
          color: context.backgroundColor,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: context.dividerColor),
        ),
        child: Row(
          children: [
            Container(
              margin:  EdgeInsets.all(12),
              width: 60,
              height: 80,
              decoration: BoxDecoration(
                color: context.surfaceColor,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            Expanded(
              child: Padding(
                padding:  EdgeInsets.symmetric(
                  vertical: 12,
                  horizontal: 4,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 12,
                      width: 160,
                      color: context.surfaceColor,
                    ),
                     SizedBox(height: 8),
                    Container(
                      height: 10,
                      width: 80,
                      color: context.surfaceColor,
                    ),
                     SizedBox(height: 8),
                    Container(
                      height: 12,
                      width: 100,
                      color: context.surfaceColor,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
