import 'package:equatable/equatable.dart';

abstract class AiTryOnEvent extends Equatable {
   const AiTryOnEvent();
}

class AiTryOnGenerate extends AiTryOnEvent {
  final String productId;
  final String userPhotoBase64;

   const AiTryOnGenerate({
    required this.productId,
    required this.userPhotoBase64,
  });

  @override
  List<Object?> get props => [productId, userPhotoBase64];
}

class AiTryOnLoadHistory extends AiTryOnEvent {
   const AiTryOnLoadHistory();

  @override
  List<Object?> get props => [];
}

class AiTryOnReset extends AiTryOnEvent {
   const AiTryOnReset();

  @override
  List<Object?> get props => [];
}
