import 'package:intl/intl.dart';

class InputConverter {
  static final _idrFormat = NumberFormat.currency(
    locale: 'id_ID',
    symbol: 'Rp ',
    decimalDigits: 0,
  );

  static final _dateFormat = DateFormat('dd MMM yyyy', 'id_ID');
  static final _dateTimeFormat = DateFormat('dd MMM yyyy, HH:mm', 'id_ID');

  static String formatIDR(int amount) => _idrFormat.format(amount);

  static String formatDate(DateTime date) => _dateFormat.format(date);

  static String formatDateTime(DateTime dateTime) =>
      _dateTimeFormat.format(dateTime);

  static String formatRelativeDate(DateTime date) {
    final now = DateTime.now();
    final diff = now.difference(date);
    if (diff.inDays == 0) return 'Hari ini';
    if (diff.inDays == 1) return 'Kemarin';
    if (diff.inDays < 7) return '${diff.inDays} hari lalu';
    return formatDate(date);
  }
}
