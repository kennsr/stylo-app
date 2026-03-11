import 'package:equatable/equatable.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/utils/either.dart';
import '../../../../core/utils/usecase.dart';
import '../entities/review.dart';
import '../repositories/product_repository.dart';

class GetReviewsParams extends Equatable {
  final String productId;

   const GetReviewsParams({required this.productId});

  @override
  List<Object?> get props => [productId];
}

class GetReviewsUseCase extends UseCase<List<Review>, GetReviewsParams> {
  final ProductRepository repository;

  GetReviewsUseCase({required this.repository});

  @override
  Future<Either<Failure, List<Review>>> call(GetReviewsParams params) {
    return repository.getReviews(params.productId);
  }
}
