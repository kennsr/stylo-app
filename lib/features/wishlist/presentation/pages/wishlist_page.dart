import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/stylo_svg_icon.dart';
import '../../../../core/theme/theme_ext.dart';
import '../bloc/wishlist_bloc.dart';
import '../bloc/wishlist_event.dart';
import '../bloc/wishlist_state.dart';
import '../widgets/wishlist_product_card.dart';

class WishlistPage extends StatefulWidget {
  const WishlistPage({super.key});

  @override
  State<WishlistPage> createState() => _WishlistPageState();
}

class _WishlistPageState extends State<WishlistPage> {
  @override
  void initState() {
    super.initState();
    // Refresh wishlist when page is opened
    context.read<WishlistBloc>().add(const WishlistLoad());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.backgroundColor,
      appBar: AppBar(
        backgroundColor: context.backgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            size: 20,
            color: context.primaryTextColor,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Wishlist Saya',
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: context.primaryTextColor,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(height: 1, color: context.dividerColor),
        ),
      ),
      body: BlocBuilder<WishlistBloc, WishlistState>(
        builder: (context, state) {
          if (state is WishlistInitial) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is WishlistError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error_outline_rounded,
                    size: 48,
                    color: context.secondaryTextColor,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    state.message,
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: context.secondaryTextColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  TextButton(
                    onPressed: () =>
                        context.read<WishlistBloc>().add(const WishlistLoad()),
                    child: Text(
                      'Coba Lagi',
                      style: GoogleFonts.poppins(color: AppColors.accent),
                    ),
                  ),
                ],
              ),
            );
          }

          if (state is WishlistLoaded) {
            if (state.items.isEmpty) {
              return _buildEmpty(context);
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: Text(
                    '${state.items.length} produk tersimpan',
                    style: GoogleFonts.poppins(
                      fontSize: 13,
                      color: context.secondaryTextColor,
                    ),
                  ),
                ),
                Expanded(
                  child: GridView.builder(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.65,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                    ),
                    itemCount: state.items.length,
                    itemBuilder: (context, index) {
                      return WishlistProductCard(product: state.items[index]);
                    },
                  ),
                ),
              ],
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildEmpty(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const StyloLogo(size: 80),
            const SizedBox(height: 20),
            Text(
              'Wishlist Kosong',
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: context.primaryTextColor,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Simpan produk favoritmu di sini\nagar mudah ditemukan nanti.',
              style: GoogleFonts.poppins(
                fontSize: 13,
                color: context.secondaryTextColor,
                height: 1.6,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
