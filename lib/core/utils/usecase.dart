import 'package:equatable/equatable.dart';
import 'either.dart';
import '../errors/failures.dart';

abstract class UseCase<ReturnType, Params> {
  Future<Either<Failure, ReturnType>> call(Params params);
}

class NoParams extends Equatable {
   const NoParams();
  @override
  List<Object?> get props => [];
}
