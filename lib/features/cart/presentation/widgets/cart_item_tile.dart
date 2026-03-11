import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../../../../core/theme/app_colors.dart';
import '../../domain/entities/cart_item.dart';
import '../bloc/cart_bloc.dart';
import '../bloc/cart_event.dart';
import '../../../../core/theme/theme_ext.dart';

class CartItemTile extends StatelessWidget {
  final CartItem item;

   const CartItemTile({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final formatter = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp ',
      decimalDigits: 0,
    );

    return Dismissible(
      key: Key(item.id),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding:  EdgeInsets.only(right: 24),
        margin:  EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        decoration: BoxDecoration(
          color: AppColors.error,
          borderRadius: BorderRadius.circular(10),
        ),
        child:  Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.delete_outline, color: Colors.white, size: 24),
            SizedBox(height: 4),
            Text(
              'Hapus',
              style: TextStyle(
                color: Colors.white,
                fontSize: 11,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
      onDismissed: (_) {
        context.read<CartBloc>().add(CartRemoveItem(cartItemId: item.id));
      },
      child: Container(
        margin:  EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        decoration: BoxDecoration(
          color: context.backgroundColor,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: context.dividerColor),
        ),
        child: Padding(
          padding:  EdgeInsets.all(12),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Product image
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: CachedNetworkImage(
                      imageUrl: item.productImage,
                      width: 60,
                      height: 80,
                      fit: BoxFit.cover,
                      placeholder: (_, _) => Container(
                        width: 60,
                        height: 80,
                        color: context.surfaceColor,
                        child:  Icon(
                          Icons.image_outlined,
                          color: context.secondaryTextColor,
                          size: 24,
                        ),
                      ),
                      errorWidget: (_, _, _) => Container(
                        width: 60,
                        height: 80,
                        color: context.surfaceColor,
                        child:  Icon(
                          Icons.broken_image_outlined,
                          color: context.secondaryTextColor,
                          size: 24,
                        ),
                      ),
                    ),
                  ),
                   SizedBox(width: 12),
                  // Product details
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.productName,
                          style: GoogleFonts.poppins(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: context.primaryTextColor,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                         SizedBox(height: 4),
                        Text(
                          '${item.size} · ${item.color}',
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            color: context.secondaryTextColor,
                          ),
                        ),
                         SizedBox(height: 6),
                        Text(
                          formatter.format(item.discountPrice ?? item.price),
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: AppColors.accent,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
               SizedBox(height: 10),
              // Bottom row: quantity stepper + delete
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _QuantityStepper(item: item),
                  GestureDetector(
                    onTap: () {
                      context
                          .read<CartBloc>()
                          .add(CartRemoveItem(cartItemId: item.id));
                    },
                    child: Container(
                      padding:  EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: context.surfaceColor,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child:  Icon(
                        Icons.delete_outline,
                        size: 18,
                        color: context.secondaryTextColor,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _QuantityStepper extends StatelessWidget {
  final CartItem item;

  const _QuantityStepper({required this.item});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _StepperButton(
          icon: Icons.remove,
          onTap: () {
            if (item.quantity <= 1) {
              context
                  .read<CartBloc>()
                  .add(CartRemoveItem(cartItemId: item.id));
            } else {
              context.read<CartBloc>().add(
                    CartUpdateQuantity(
                      cartItemId: item.id,
                      quantity: item.quantity - 1,
                    ),
                  );
            }
          },
        ),
        Container(
          constraints:  BoxConstraints(minWidth: 36),
          alignment: Alignment.center,
          child: Text(
            '${item.quantity}',
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: context.primaryTextColor,
            ),
          ),
        ),
        _StepperButton(
          icon: Icons.add,
          onTap: () {
            context.read<CartBloc>().add(
                  CartUpdateQuantity(
                    cartItemId: item.id,
                    quantity: item.quantity + 1,
                  ),
                );
          },
        ),
      ],
    );
  }
}

class _StepperButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _StepperButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          color: AppColors.accent.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Icon(icon, size: 16, color: AppColors.accent),
      ),
    );
  }
}
