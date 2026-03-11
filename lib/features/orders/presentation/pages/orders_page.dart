import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/theme/app_colors.dart';
import '../bloc/orders_bloc.dart';
import '../bloc/orders_event.dart';
import '../bloc/orders_state.dart';
import '../widgets/order_card.dart';
import '../../../../core/theme/theme_ext.dart';

class OrdersPage extends StatefulWidget {
   const OrdersPage({super.key});

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  static const _tabs = [
    'Semua',
    'Belum Bayar',
    'Diproses',
    'Dikirim',
    'Selesai',
  ];

  static const _statusFilters = [
    null,
    'pending',
    'processing',
    'shipped',
    'completed',
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);
    context.read<OrdersBloc>().add( OrdersFetch());
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.surfaceColor,
      appBar: AppBar(
        backgroundColor: context.backgroundColor,
        elevation: 0,
        scrolledUnderElevation: 0,
        automaticallyImplyLeading: false,
        title: Text(
          'Pesanan Saya',
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: context.primaryTextColor,
          ),
        ),
        centerTitle: true,
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          tabAlignment: TabAlignment.start,
          labelColor: AppColors.accent,
          unselectedLabelColor: context.secondaryTextColor,
          indicatorColor: AppColors.accent,
          indicatorWeight: 2,
          indicatorSize: TabBarIndicatorSize.label,
          dividerColor: context.dividerColor,
          labelStyle: GoogleFonts.poppins(
            fontSize: 13,
            fontWeight: FontWeight.w600,
          ),
          unselectedLabelStyle: GoogleFonts.poppins(
            fontSize: 13,
            fontWeight: FontWeight.w500,
          ),
          padding:  EdgeInsets.symmetric(horizontal: 8),
          tabs: _tabs.map((t) => Tab(text: t)).toList(),
        ),
      ),
      body: BlocBuilder<OrdersBloc, OrdersState>(
        builder: (context, state) {
          if (state is OrdersLoading) {
            return  Center(
              child: CircularProgressIndicator(
                color: AppColors.accent,
                strokeWidth: 2,
              ),
            );
          }

          if (state is OrdersError) {
            return Center(
              child: Padding(
                padding:  EdgeInsets.all(32),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 72,
                      height: 72,
                      decoration: BoxDecoration(
                        color: AppColors.error.withValues(alpha: 0.1),
                        shape: BoxShape.circle,
                      ),
                      child:  Icon(
                        Icons.error_outline,
                        size: 36,
                        color: AppColors.error,
                      ),
                    ),
                     SizedBox(height: 16),
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
                          context.read<OrdersBloc>().add( OrdersFetch()),
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
                        'Coba Lagi',
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

          if (state is OrdersLoaded) {
            return TabBarView(
              controller: _tabController,
              children: List.generate(_tabs.length, (i) {
                final filter = _statusFilters[i];
                final filtered = filter == null
                    ? state.orders
                    : state.orders
                          .where(
                            (o) =>
                                o.status.toLowerCase().contains(filter) ||
                                o.status.toLowerCase() == filter,
                          )
                          .toList();

                if (filtered.isEmpty) {
                  return _EmptyTabState(tabName: _tabs[i]);
                }

                return RefreshIndicator(
                  color: AppColors.accent,
                  onRefresh: () async {
                    context.read<OrdersBloc>().add( OrdersFetch());
                  },
                  child: ListView.builder(
                    padding:  EdgeInsets.symmetric(vertical: 8),
                    itemCount: filtered.length,
                    itemBuilder: (context, index) {
                      return OrderCard(order: filtered[index]);
                    },
                  ),
                );
              }),
            );
          }

          return  SizedBox.shrink();
        },
      ),
    );
  }
}

class _EmptyTabState extends StatelessWidget {
  final String tabName;

  const _EmptyTabState({required this.tabName});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding:  EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
             Icon(
              Icons.receipt_long_outlined,
              size: 72,
              color: context.secondaryTextColor,
            ),
             SizedBox(height: 20),
            Text(
              'Belum ada pesanan',
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: context.primaryTextColor,
              ),
            ),
             SizedBox(height: 8),
            Text(
              'Pesanan dengan status "$tabName" belum ada',
              style: GoogleFonts.poppins(
                fontSize: 13,
                color: context.secondaryTextColor,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
