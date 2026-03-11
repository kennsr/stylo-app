import '../../../../core/errors/failures.dart';
import '../../../../core/utils/either.dart';
import '../../../../core/utils/usecase.dart';
import '../entities/banner.dart';
import '../repositories/home_repository.dart';

class GetBannersUseCase extends UseCase<List<Banner>, NoParams> {
  final HomeRepository repository;

  GetBannersUseCase(this.repository);

  @override
  Future<Either<Failure, List<Banner>>> call(NoParams params) =>
      repository.getBanners();
}
