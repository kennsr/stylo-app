sealed class Either<L, R> {
   Either();

  bool get isLeft => this is Left<L, R>;
  bool get isRight => this is Right<L, R>;

  T fold<T>(T Function(L left) onLeft, T Function(R right) onRight) {
    if (this is Left<L, R>) return onLeft((this as Left<L, R>).value);
    return onRight((this as Right<L, R>).value);
  }

  R getOrElse(R Function(L left) orElse) {
    if (this is Right<L, R>) return (this as Right<L, R>).value;
    return orElse((this as Left<L, R>).value);
  }

  Either<L, T> map<T>(T Function(R right) f) {
    if (this is Right<L, R>) return Right(f((this as Right<L, R>).value));
    return Left((this as Left<L, R>).value);
  }
}

final class Left<L, R> extends Either<L, R> {
  final L value;
   Left(this.value);
}

final class Right<L, R> extends Either<L, R> {
  final R value;
   Right(this.value);
}
