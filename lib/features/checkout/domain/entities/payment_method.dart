class PaymentMethod {
  final String id;
  final String name;
  final String provider; // e.g. 'Midtrans', 'Stripe', 'Internal'

  const PaymentMethod({
    required this.id,
    required this.name,
    required this.provider,
  });

  factory PaymentMethod.fromJson(Map<String, dynamic> json) {
    return PaymentMethod(
      id: json['id'] as String,
      name: json['name'] as String,
      provider: json['provider'] as String? ?? '',
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PaymentMethod &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}
