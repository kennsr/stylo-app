class BodyAvatar {
  final String id;
  final String name; // optional — not returned by current backend contract
  final String imageUrl;

  const BodyAvatar({
    required this.id,
    this.name = '',
    required this.imageUrl,
  });

  factory BodyAvatar.fromJson(Map<String, dynamic> json) {
    return BodyAvatar(
      id: json['id'] as String,
      name: json['name'] as String? ?? '',
      // API contract uses 'url'; also accept 'image_url' / 'imageUrl' for compat
      imageUrl: json['url'] as String? ??
          json['image_url'] as String? ??
          json['imageUrl'] as String? ??
          '',
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BodyAvatar &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}
