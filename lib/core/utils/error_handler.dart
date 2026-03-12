import '../../../../core/constants/env_config.dart';
import '../../../../core/errors/failures.dart';

/// Centralized error message handler that shows:
/// - Detailed messages in non-production environments (for debugging)
/// - Generic user-friendly messages in production
class ErrorHandler {
  /// Get user-friendly error message based on environment
  static String getMessage({
    Failure? failure,
    String? customMessage,
    String? rawMessage,
  }) {
    // In non-production environments, show detailed messages for debugging
    if (!EnvConfig.isProduction) {
      if (customMessage != null) return customMessage;
      if (rawMessage != null) return rawMessage;
      if (failure != null) return _getDetailedMessage(failure);
      return 'Terjadi kesalahan.';
    }
    
    // In production, show generic user-friendly messages
    if (failure != null) return _getProductionMessage(failure);
    if (rawMessage != null) return _getProductionMessageFromRaw(rawMessage);
    if (customMessage != null) return _getProductionMessageFromRaw(customMessage);
    
    return 'Terjadi kesalahan pada sistem. Silakan hubungi Customer Service kami di halaman Bantuan untuk bantuan lebih lanjut.';
  }
  
  /// Get detailed error message for debugging (non-production only)
  static String _getDetailedMessage(Failure failure) {
    if (failure is ServerFailure) {
      return failure.message;
    } else if (failure is AuthFailure) {
      return failure.message;
    } else if (failure is NetworkFailure) {
      return 'Tidak ada koneksi internet. Periksa koneksi Anda dan coba lagi.';
    } else if (failure is CacheFailure) {
      return 'Gagal menyimpan data lokal. Silakan coba lagi.';
    } else if (failure is ValidationFailure) {
      return failure.message;
    } else if (failure is NotFoundFailure) {
      return failure.message;
    }
    
    return 'Terjadi kesalahan: ${failure.message}';
  }
  
  /// Get generic user-friendly message for production
  static String _getProductionMessage(Failure failure) {
    // Network errors should still be specific since they're common
    if (failure is NetworkFailure) {
      return 'Tidak ada koneksi internet. Periksa koneksi Anda dan coba lagi.';
    }
    
    // Validation errors should show the specific issue
    if (failure is ValidationFailure) {
      return failure.message;
    }
    
    // All other errors show generic message with CS contact
    return 'Terjadi kesalahan pada sistem. Silakan hubungi Customer Service kami di halaman Bantuan untuk bantuan lebih lanjut.';
  }
  
  /// Get production message from raw string
  static String _getProductionMessageFromRaw(String message) {
    final lowerMessage = message.toLowerCase();
    
    // Network-related errors
    if (lowerMessage.contains('network') || lowerMessage.contains('koneksi') || 
        lowerMessage.contains('internet') || lowerMessage.contains('no network')) {
      return 'Tidak ada koneksi internet. Periksa koneksi Anda dan coba lagi.';
    }
    
    // File size errors (413)
    if (isEntityTooLarge(message)) {
      return 'Ukuran foto terlalu besar. Silakan pilih foto dengan ukuran kurang dari 2MB. Jika masalah berlanjut, hubungi Customer Service kami.';
    }
    
    // Authentication errors
    if (lowerMessage.contains('auth') || lowerMessage.contains('token') || 
        lowerMessage.contains('session') || lowerMessage.contains('login')) {
      return 'Sesi Anda telah habis. Silakan login kembali.';
    }
    
    // Server errors
    if (lowerMessage.contains('server') || lowerMessage.contains('500') ||
        lowerMessage.contains('502') || lowerMessage.contains('503')) {
      return 'Terjadi kesalahan pada server. Silakan coba lagi nanti atau hubungi Customer Service kami.';
    }
    
    // Default generic message
    return 'Terjadi kesalahan pada sistem. Silakan hubungi Customer Service kami di halaman Bantuan untuk bantuan lebih lanjut.';
  }
  
  /// Check if an error is a "request entity too large" (HTTP 413)
  static bool isEntityTooLarge(String message) {
    final lowerMessage = message.toLowerCase();
    return lowerMessage.contains('413') ||
           lowerMessage.contains('entity too large') ||
           lowerMessage.contains('request entity too large') ||
           lowerMessage.contains('payload too large');
  }
  
  /// Get appropriate message for file upload errors
  static String getFileUploadMessage({
    required String message,
  }) {
    // Handle 413 errors specifically
    if (isEntityTooLarge(message)) {
      if (EnvConfig.isProduction) {
        return 'Ukuran foto terlalu besar. Silakan pilih foto dengan ukuran kurang dari 2MB. Jika masalah berlanjut, hubungi Customer Service kami.';
      } else {
        return 'Error 413: Request Entity Too Large. Ukuran foto melebihi batas server. Maksimum 2MB.';
      }
    }
    
    // For other upload errors, use generic handler
    return getMessage(rawMessage: message);
  }
}
