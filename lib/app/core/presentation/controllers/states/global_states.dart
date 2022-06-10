import 'base_states.dart';

class NoInternetConnectionState implements ErrorState {}

class ServerErrorState implements ErrorState {
  final String message;

  ServerErrorState({required this.message});
}

class UnknownErrorState implements ErrorState {
  final String message;

  UnknownErrorState({required this.message});
}
