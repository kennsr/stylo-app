import '../../../../core/errors/failures.dart';
import '../../../../core/utils/either.dart';
import '../../../../core/utils/usecase.dart';
import '../entities/category.dart';
import '../repositories/home_repository.dart';

class GetCategoriesUseCase extends UseCase<List<Category>, NoParams> {
  final HomeRepository repository;

  GetCategoriesUseCase(this.repository);

  @override
  Future<Either<Failure, List<Category>>> call(NoParams params) =>
      repository.getCategories();
}
