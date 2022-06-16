import 'failure.dart';

class ServerFailure extends Failure {
  const ServerFailure({super.message});
}

class StorageFailure extends Failure {}

class NoInternetConnectionFailure extends Failure {}

class UnknownFailure extends Failure {
  const UnknownFailure({super.message});
}
