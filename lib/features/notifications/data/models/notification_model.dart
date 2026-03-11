import '../../domain/entities/notification_item.dart';

class NotificationModel extends NotificationItem {
  const NotificationModel({
    required super.id,
    required super.title,
    required super.body,
    required super.type,
    required super.isRead,
    required super.createdAt,
    super.imageUrl,
    super.actionRoute,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      NotificationModel(
        id: json['id'] as String,
        title: json['title'] as String,
        body: json['body'] as String,
        type: json['type'] as String,
        isRead: json['is_read'] as bool? ?? false,
        createdAt: DateTime.parse(json['created_at'] as String),
        imageUrl: json['image_url'] as String?,
        actionRoute: json['action_route'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'body': body,
        'type': type,
        'is_read': isRead,
        'created_at': createdAt.toIso8601String(),
        'image_url': imageUrl,
        'action_route': actionRoute,
      };

  NotificationModel copyWith({bool? isRead}) => NotificationModel(
        id: id,
        title: title,
        body: body,
        type: type,
        isRead: isRead ?? this.isRead,
        createdAt: createdAt,
        imageUrl: imageUrl,
        actionRoute: actionRoute,
      );
}
