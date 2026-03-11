import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/theme_ext.dart';

class AddToCartBar extends StatefulWidget {
  final VoidCallback? onAddToCart;
  final int initialQuantity;

   const AddToCartBar({
    super.key,
    this.onAddToCart,
    this.initialQuantity = 1,
  });

  @override
  State<AddToCartBar> createState() => _AddToCartBarState();
}

class _AddToCartBarState extends State<AddToCartBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 76,
      padding:  EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration:  BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(color: context.borderColor, width: 1),
        ),
      ),
      child: Row(
        children: [
          // Cart icon button
          GestureDetector(
            onTap: () {},
            child: Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: context.borderColor),
                borderRadius: BorderRadius.circular(10),
              ),
              child:  Icon(
                Icons.shopping_bag_outlined,
                color: context.primaryTextColor,
                size: 22,
              ),
            ),
          ),
           SizedBox(width: 10),
          // Add to cart button
          Expanded(
            child: SizedBox(
              height: 48,
              child: ElevatedButton.icon(
                onPressed: widget.onAddToCart,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.accent,
                  foregroundColor: Colors.white,
                  disabledBackgroundColor: context.borderColor,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: EdgeInsets.zero,
                ),
                icon:  Icon(
                  Icons.add_shopping_cart_rounded,
                  size: 18,
                ),
                label: Text(
                  'Tambah ke Keranjang',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
