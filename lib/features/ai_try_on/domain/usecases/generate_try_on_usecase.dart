import 'package:equatable/equatable.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/utils/either.dart';
import '../../../../core/utils/usecase.dart';
import '../entities/try_on_result.dart';
import '../repositories/ai_try_on_repository.dart';

class GenerateTryOnParams extends Equatable {
  final String productId;
  final String userPhotoBase64;

   const GenerateTryOnParams({
    required this.productId,
    required this.userPhotoBase64,
  });

  @override
  List<Object?> get props => [productId, userPhotoBase64];
}

class GenerateTryOnUseCase extends UseCase<TryOnResult, GenerateTryOnParams> {
  final AiTryOnRepository repository;

  GenerateTryOnUseCase({required this.repository});

  @override
  Future<Either<Failure, TryOnResult>> call(GenerateTryOnParams params) {
    return repository.generateTryOn(
      productId: params.productId,
      userPhotoBase64: params.userPhotoBase64,
    );
  }
}
