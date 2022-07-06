abstract class Either<L, R> {
  bool get isLeft;
  bool get isRight;

  T evaluate<T>(T Function(L l) leftFn, T Function(R r) rightFn);

  R getOrElse(R Function(L left) orElse);
}

class _Left<L, R> extends Either<L, R> {
  final L _value;

  @override
  final bool isLeft = true;

  @override
  final bool isRight = false;

  _Left(this._value);

  @override
  T evaluate<T>(T Function(L l) leftFn, T Function(R r) rightFn) {
    return leftFn(_value);
  }

  @override
  R getOrElse(R Function(L l) orElse) {
    return orElse(_value);
  }
}

class _Right<L, R> extends Either<L, R> {
  final R _value;

  @override
  final bool isLeft = false;

  @override
  final bool isRight = true;

  _Right(this._value);

  @override
  T evaluate<T>(T Function(L l) leftFn, T Function(R r) rightFn) {
    return rightFn(_value);
  }

  @override
  R getOrElse(R Function(L l) orElse) {
    return _value;
  }
}

Either<L, R> right<L, R>(R r) => _Right<L, R>(r);
Either<L, R> left<L, R>(L l) => _Left<L, R>(l);

T id<T>(T value) => value;
