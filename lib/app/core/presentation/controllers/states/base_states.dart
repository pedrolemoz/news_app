abstract class AppState {}

class IdleState implements AppState {}

abstract class ErrorState extends AppState {}

abstract class ProcessingState extends AppState {}

abstract class SuccessState extends AppState {}
