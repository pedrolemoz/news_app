import 'failure.dart';

class ServerFailure extends Failure {
  const ServerFailure({super.message});
}

class NoInternetConnectionFailure extends Failure {}
