import '../../domain/failures/failure.dart';

abstract class AppException implements Exception {
  Failure get asFailure;
}
