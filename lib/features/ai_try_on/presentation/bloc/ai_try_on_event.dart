import 'package:equatable/equatable.dart';

abstract class AiTryOnEvent extends Equatable {
  const AiTryOnEvent();
}

class AiTryOnGenerate extends AiTryOnEvent {
  final String productId;
  final String? userPhotoBase64;
  final String? avatarId;

  const AiTryOnGenerate({
    required this.productId,
    this.userPhotoBase64,
    this.avatarId,
  });

  @override
  List<Object?> get props => [productId, userPhotoBase64, avatarId];
}

class AiTryOnLoadAvatars extends AiTryOnEvent {
  const AiTryOnLoadAvatars();

  @override
  List<Object?> get props => [];
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
