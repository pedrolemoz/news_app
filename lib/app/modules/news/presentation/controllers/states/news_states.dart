import '../../../../../core/presentation/controllers/states/base_states.dart';

class SuccessfullyGotNewsState implements SuccessState {}

class LoadedAllNewsState implements SuccessState {}

class GettingInitialNewsState implements ProcessingState {}

class GettingMoreNewsState implements ProcessingState {}

class RefreshingNewsState implements ProcessingState {}

class NoNewsToShowState implements ErrorState {}

class InvalidLastDocumentState implements ErrorState {}
