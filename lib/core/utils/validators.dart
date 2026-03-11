class Validators {
  static String? email(String? value) {
    if (value == null || value.isEmpty) return 'Email tidak boleh kosong';
    final regex = RegExp(r'^[^@]+@[^@]+\.[^@]+$');
    if (!regex.hasMatch(value)) return 'Format email tidak valid';
    return null;
  }

  static String? password(String? value) {
    if (value == null || value.isEmpty) return 'Kata sandi tidak boleh kosong';
    if (value.length < 6) return 'Kata sandi minimal 6 karakter';
    return null;
  }

  static String? confirmPassword(String? value, String? original) {
    if (value == null || value.isEmpty) {
      return 'Konfirmasi kata sandi tidak boleh kosong';
    }
    if (value != original) return 'Kata sandi tidak cocok';
    return null;
  }

  static String? name(String? value) {
    if (value == null || value.isEmpty) return 'Nama tidak boleh kosong';
    if (value.length < 2) return 'Nama minimal 2 karakter';
    return null;
  }

  static String? phone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Nomor telepon tidak boleh kosong';
    }
    final cleaned = value.replaceAll(RegExp(r'[\s\-]'), '');
    final regex = RegExp(r'^(\+62|62|0)8[1-9][0-9]{6,10}$');
    if (!regex.hasMatch(cleaned)) return 'Nomor telepon tidak valid';
    return null;
  }

  static String? required(String? value, [String fieldName = 'Field']) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName tidak boleh kosong';
    }
    return null;
  }
}
