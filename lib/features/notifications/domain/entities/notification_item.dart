class NotificationItem {
  final String id;
  final String title;
  final String body;
  final String type; // 'promo', 'order_update', 'system'
  final bool isRead;
  final DateTime createdAt;
  final String? imageUrl;
  final String? actionRoute;

  const NotificationItem({
    required this.id,
    required this.title,
    required this.body,
    required this.type,
    required this.isRead,
    required this.createdAt,
    this.imageUrl,
    this.actionRoute,
  });
}
