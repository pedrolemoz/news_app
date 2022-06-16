import '../../domain/failures/core_failures.dart';
import '../../domain/failures/failure.dart';
import 'app_exception.dart';

class NoInternetConnectionException implements AppException {
  const NoInternetConnectionException();

  @override
  Failure get asFailure => NoInternetConnectionFailure();
}

class ServerException implements AppException {
  final String data;

  const ServerException({required this.data});

  @override
  Failure get asFailure => ServerFailure();
}

class StorageException implements AppException {
  const StorageException();

  @override
  Failure get asFailure => StorageFailure();
}

class UnknownException implements AppException {
  final String data;

  const UnknownException({required this.data});

  @override
  Failure get asFailure => UnknownFailure();
}
