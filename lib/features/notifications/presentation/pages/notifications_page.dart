import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/theme_ext.dart';
import '../bloc/notifications_bloc.dart';
import '../bloc/notifications_event.dart';
import '../bloc/notifications_state.dart';
import '../widgets/notification_tile.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.backgroundColor,
      appBar: _buildAppBar(context),
      body: BlocBuilder<NotificationsBloc, NotificationsState>(
        builder: (context, state) {
          if (state is NotificationsLoading || state is NotificationsInitial) {
            return _buildShimmerList(context);
          }

          if (state is NotificationsError) {
            return _buildErrorView(context, state.message);
          }

          if (state is NotificationsLoaded) {
            if (state.notifications.isEmpty) {
              return _buildEmptyView(context);
            }
            return _buildNotificationsList(context, state);
          }

          return _buildShimmerList(context);
        },
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: context.backgroundColor,
      elevation: 0,
      scrolledUnderElevation: 0.5,
      shadowColor: context.dividerColor,
      title: Text(
        'Notifikasi',
        style: GoogleFonts.poppins(
          fontSize: 18,
          fontWeight: FontWeight.w700,
          color: context.primaryTextColor,
        ),
      ),
      actions: [
        BlocBuilder<NotificationsBloc, NotificationsState>(
          builder: (context, state) {
            if (state is NotificationsLoaded && state.unreadCount > 0) {
              return TextButton(
                onPressed: () {
                  context
                      .read<NotificationsBloc>()
                      .add(const NotificationsMarkAllRead());
                },
                child: Text(
                  'Tandai semua dibaca',
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                    color: AppColors.accent,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ],
    );
  }

  Widget _buildShimmerList(BuildContext context) {
    return ListView.separated(
      itemCount: 8,
      separatorBuilder: (context, index) => Divider(
        height: 1,
        color: context.dividerColor,
      ),
      itemBuilder: (context, index) => Shimmer.fromColors(
        baseColor: AppColors.shimmerBase,
        highlightColor: AppColors.shimmerHighlight,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 14,
                      width: double.infinity,
                      color: Colors.white,
                    ),
                    const SizedBox(height: 8),
                    Container(
                      height: 12,
                      width: double.infinity,
                      color: Colors.white,
                    ),
                    const SizedBox(height: 4),
                    Container(
                      height: 12,
                      width: 120,
                      color: Colors.white,
                    ),
                    const SizedBox(height: 6),
                    Container(
                      height: 10,
                      width: 80,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildErrorView(BuildContext context, String message) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.wifi_off_rounded,
              size: 64,
              color: context.secondaryTextColor,
            ),
            const SizedBox(height: 16),
            Text(
              'Terjadi Kesalahan',
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: context.primaryTextColor,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              message,
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: context.secondaryTextColor,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () {
                context
                    .read<NotificationsBloc>()
                    .add(const NotificationsFetch());
              },
              icon: const Icon(Icons.refresh_rounded),
              label: Text(
                'Coba Lagi',
                style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.accent,
                foregroundColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyView(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.notifications_none_rounded,
              size: 72,
              color: context.secondaryTextColor,
            ),
            const SizedBox(height: 16),
            Text(
              'Belum ada notifikasi',
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: context.primaryTextColor,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Notifikasi terbaru kamu akan muncul di sini',
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: context.secondaryTextColor,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNotificationsList(
    BuildContext context,
    NotificationsLoaded state,
  ) {
    final unread =
        state.notifications.where((n) => !n.isRead).toList();
    final read = state.notifications.where((n) => n.isRead).toList();

    return RefreshIndicator(
      color: AppColors.accent,
      onRefresh: () async {
        context.read<NotificationsBloc>().add(const NotificationsFetch());
        await Future.delayed(const Duration(milliseconds: 500));
      },
      child: ListView(
        children: [
          if (unread.isNotEmpty) ...[
            _buildSectionLabel(context, 'Belum Dibaca'),
            ...unread.map(
              (notification) => Column(
                children: [
                  NotificationTile(
                    notification: notification,
                    onTap: () => _onTileTap(context, notification),
                  ),
                  Divider(height: 1, color: context.dividerColor),
                ],
              ),
            ),
          ],
          if (read.isNotEmpty) ...[
            if (unread.isNotEmpty)
              Divider(height: 1, thickness: 4, color: context.surfaceColor),
            _buildSectionLabel(context, 'Sudah Dibaca'),
            ...read.map(
              (notification) => Column(
                children: [
                  NotificationTile(
                    notification: notification,
                    onTap: () => _onTileTap(context, notification),
                  ),
                  Divider(height: 1, color: context.dividerColor),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildSectionLabel(BuildContext context, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      color: context.surfaceColor,
      child: Text(
        label,
        style: GoogleFonts.poppins(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: context.secondaryTextColor,
          letterSpacing: 0.5,
        ),
      ),
    );
  }

  void _onTileTap(BuildContext context, notification) {
    // Mark as read
    context
        .read<NotificationsBloc>()
        .add(NotificationsMarkRead(id: notification.id));

    // Navigate if actionRoute is set
    if (notification.actionRoute != null &&
        notification.actionRoute!.isNotEmpty) {
      context.push(notification.actionRoute!);
    }
  }
}
