import 'package:dartz/dartz.dart';

import '../errors/failure.dart';

abstract class AsyncUsecase<Type, Parameters> {
  Future<Either<Failure, Type>> call(Parameters parameters);
}
