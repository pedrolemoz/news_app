import 'package:dartz/dartz.dart';

import '../errors/failure.dart';

abstract class Usecase<Type, Parameters> {
  Either<Failure, Type> call(Parameters parameters);
}
