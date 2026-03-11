import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../../core/theme/app_colors.dart';
import '../bloc/order_detail_bloc.dart';
import '../bloc/order_detail_event.dart';
import '../bloc/order_detail_state.dart';
import '../widgets/order_status_badge.dart';
import '../../../../core/theme/theme_ext.dart';

class OrderDetailPage extends StatefulWidget {
  final String orderId;

   const OrderDetailPage({super.key, required this.orderId});

  @override
  State<OrderDetailPage> createState() => _OrderDetailPageState();
}

class _OrderDetailPageState extends State<OrderDetailPage> {
  @override
  void initState() {
    super.initState();
    context
        .read<OrderDetailBloc>()
        .add(OrderDetailFetch(orderId: widget.orderId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text('Detail Pesanan'),
        centerTitle: true,
      ),
      body: BlocBuilder<OrderDetailBloc, OrderDetailState>(
        builder: (context, state) {
          if (state is OrderDetailLoading) {
            return  Center(child: CircularProgressIndicator());
          }

          if (state is OrderDetailError) {
            return Center(
              child: Padding(
                padding:  EdgeInsets.all(24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.error_outline,
                        size: 64, color: Colors.red[300]),
                     SizedBox(height: 16),
                    Text(state.message,
                        textAlign: TextAlign.center),
                     SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () => context
                          .read<OrderDetailBloc>()
                          .add(OrderDetailFetch(orderId: widget.orderId)),
                      child:  Text('Coba Lagi'),
                    ),
                  ],
                ),
              ),
            );
          }

          if (state is OrderDetailLoaded) {
            final order = state.order;
            final currencyFormatter = NumberFormat.currency(
              locale: 'id_ID',
              symbol: 'Rp ',
              decimalDigits: 0,
            );
            final dateFormatter =
                DateFormat('dd MMM yyyy, HH:mm', 'id_ID');

            return SingleChildScrollView(
              padding:  EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _InfoCard(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                order.orderNumber,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium
                                    ?.copyWith(fontWeight: FontWeight.w700),
                              ),
                               SizedBox(height: 4),
                              Text(
                                dateFormatter.format(order.createdAt),
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(
                                      color: context.secondaryTextColor,
                                    ),
                              ),
                            ],
                          ),
                          OrderStatusBadge(status: order.status),
                        ],
                      ),
                    ],
                  ),
                   SizedBox(height: 12),
                  _SectionTitle(title: 'Informasi Penerima'),
                  _InfoCard(
                    children: [
                      _InfoRow(
                          label: 'Nama',
                          value: order.receiverName),
                      _InfoRow(label: 'Telepon', value: order.phone),
                      _InfoRow(label: 'Alamat', value: order.address),
                    ],
                  ),
                   SizedBox(height: 12),
                  _SectionTitle(title: 'Informasi Pengiriman'),
                  _InfoCard(
                    children: [
                      _InfoRow(
                        label: 'Kurir',
                        value:
                            '${order.shippingCourier} - ${order.shippingService}',
                      ),
                    ],
                  ),
                   SizedBox(height: 12),
                  _SectionTitle(title: 'Produk yang Dipesan'),
                  ...order.items.map(
                    (item) => _ItemTile(
                      item: item,
                      formatter: currencyFormatter,
                    ),
                  ),
                   SizedBox(height: 12),
                  _SectionTitle(title: 'Ringkasan Pembayaran'),
                  _InfoCard(
                    children: [
                      _InfoRow(
                        label: 'Metode Pembayaran',
                        value: order.paymentMethod,
                      ),
                      _InfoRow(
                        label: 'Subtotal',
                        value: currencyFormatter.format(order.subtotal),
                      ),
                      _InfoRow(
                        label: 'Ongkos Kirim',
                        value: currencyFormatter.format(order.shippingCost),
                      ),
                       Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Total',
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall
                                ?.copyWith(fontWeight: FontWeight.w700),
                          ),
                          Text(
                            currencyFormatter.format(order.total),
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall
                                ?.copyWith(
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.accent,
                                ),
                          ),
                        ],
                      ),
                    ],
                  ),
                   SizedBox(height: 24),
                ],
              ),
            );
          }

          return  SizedBox.shrink();
        },
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;

  const _SectionTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.only(bottom: 8),
      child: Text(
        title,
        style: Theme.of(context)
            .textTheme
            .titleSmall
            ?.copyWith(fontWeight: FontWeight.w700),
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  final List<Widget> children;

  const _InfoCard({required this.children});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding:  EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 4,
            offset:  Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children,
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;

  const _InfoRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: context.secondaryTextColor,
                  ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ItemTile extends StatelessWidget {
  final dynamic item;
  final NumberFormat formatter;

  const _ItemTile({required this.item, required this.formatter});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin:  EdgeInsets.only(bottom: 8),
      padding:  EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 4,
            offset:  Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          if (item.productImage != null)
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: CachedNetworkImage(
                imageUrl: item.productImage!,
                width: 56,
                height: 56,
                fit: BoxFit.cover,
                placeholder: (_, _) => Container(
                  width: 56,
                  height: 56,
                  color: Colors.grey[200],
                ),
                errorWidget: (_, _, _) => Container(
                  width: 56,
                  height: 56,
                  color: Colors.grey[200],
                  child:  Icon(Icons.broken_image, color: Colors.grey),
                ),
              ),
            )
          else
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(6),
              ),
              child:  Icon(Icons.image, color: Colors.grey),
            ),
           SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.productName,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(fontWeight: FontWeight.w500),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                 SizedBox(height: 2),
                Text(
                  '${item.size} · ${item.color}',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: context.secondaryTextColor,
                      ),
                ),
                 SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'x${item.quantity}',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    Text(
                      formatter.format(item.price * item.quantity),
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall
                          ?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: AppColors.accent,
                          ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
