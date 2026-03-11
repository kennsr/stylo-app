import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;
   const Failure({this.message = ''});

  @override
  List<Object> get props => [message];
}

class ServerFailure extends Failure {
   const ServerFailure({super.message = 'Terjadi kesalahan pada server.'});
}

class CacheFailure extends Failure {
   const CacheFailure({super.message = 'Tidak dapat membaca data lokal.'});
}

class NetworkFailure extends Failure {
   const NetworkFailure({super.message = 'Tidak ada koneksi internet.'});
}

class AuthFailure extends Failure {
   const AuthFailure({super.message = 'Sesi habis. Silakan masuk kembali.'});
}

class ValidationFailure extends Failure {
   const ValidationFailure({required super.message});
}

class NotFoundFailure extends Failure {
   const NotFoundFailure({super.message = 'Data tidak ditemukan.'});
}
