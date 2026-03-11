import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../../../core/theme/app_colors.dart';
import '../../domain/entities/order_summary.dart';
import 'order_status_badge.dart';
import '../../../../core/theme/theme_ext.dart';

class OrderCard extends StatelessWidget {
  final OrderSummary order;

   const OrderCard({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    final currencyFormatter = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp ',
      decimalDigits: 0,
    );
    final dateFormatter = DateFormat('dd MMM yyyy', 'id_ID');

    return GestureDetector(
      onTap: () => context.go('/orders/${order.id}'),
      child: Container(
        margin:  EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        padding:  EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 4,
              offset:  Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  order.orderNumber,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                ),
                OrderStatusBadge(status: order.status),
              ],
            ),
             SizedBox(height: 4),
            Text(
              dateFormatter.format(order.createdAt),
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: context.secondaryTextColor,
                  ),
            ),
             SizedBox(height: 12),
            Row(
              children: [
                if (order.firstItemImage != null)
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: CachedNetworkImage(
                      imageUrl: order.firstItemImage!,
                      width: 56,
                      height: 56,
                      fit: BoxFit.cover,
                      placeholder: (_, _) => Container(
                        width: 56,
                        height: 56,
                        color: Colors.grey[200],
                        child:  Icon(Icons.image,
                            color: Colors.grey, size: 20),
                      ),
                      errorWidget: (_, _, _) => Container(
                        width: 56,
                        height: 56,
                        color: Colors.grey[200],
                        child:  Icon(Icons.broken_image,
                            color: Colors.grey, size: 20),
                      ),
                    ),
                  )
                else
                  Container(
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child:  Icon(Icons.shopping_bag,
                        color: Colors.grey, size: 24),
                  ),
                 SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (order.firstItemName != null)
                        Text(
                          order.firstItemName!,
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    fontWeight: FontWeight.w500,
                                  ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      Text(
                        '${order.itemCount} item',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: context.secondaryTextColor,
                            ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
             SizedBox(height: 12),
             Divider(height: 1),
             SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total Pesanan',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                Text(
                  currencyFormatter.format(order.total),
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: AppColors.accent,
                      ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
