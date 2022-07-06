import 'package:bloc/bloc.dart';

import '../../../domain/entities/news.dart';
import '../../../domain/failures/core_failures.dart';
import '../../../domain/failures/news_failures.dart';
import '../../../domain/requests/get_news_request.dart';
import '../../../domain/usecases/get_news.dart';
import '../../../utils/constants.dart';
import '../events/news_events.dart';
import '../states/base_states.dart';
import '../states/global_states.dart';
import '../states/news_states.dart';

class NewsBloc extends Bloc<NewsEvents, AppState> {
  final GetNews _getNews;

  NewsBloc(this._getNews) : super(IdleState()) {
    on<GetNewsEvent>(_onGetNewsEvent);
    on<RefreshNewsEvent>(_onRefreshNewsEvent);
  }

  int currentQuantity = 0;
  List<News> news = [];

  Future<void> _onGetNewsEvent(
    NewsEvents event,
    Emitter<AppState> emit,
  ) async {
    if (state is LoadedAllNewsState) return;

    if (state is RefreshingNewsState ||
        state is! RefreshingNewsState && currentQuantity == 0) {
      emit(GettingInitialNewsState());
    } else {
      emit(GettingMoreNewsState());
    }

    final result = await _getNews(
      GetNewsRequest(
        shouldUseLastDocumentReference: news.isNotEmpty,
        lastDocumentReference: news.isNotEmpty ? news.last.reference : null,
      ),
    );

    result.evaluate(
      (failure) {
        switch (failure.runtimeType) {
          case InvalidLastDocumentFailure:
            news.clear();
            currentQuantity = 0;
            emit(InvalidLastDocumentState());
            break;
          case NoNewsToShowFailure:
            news.clear();
            currentQuantity = 0;
            emit(NoNewsToShowState());
            break;
          case NoInternetConnectionFailure:
            emit(NoInternetConnectionState());
            break;
          case ServerFailure:
            emit(ServerErrorState(message: failure.message!));
            break;
          default:
            emit(UnknownErrorState(message: failure.message!));
            break;
        }
      },
      (success) async {
        news.addAll(success.toList());
        final receivedQuantity = success.length;
        currentQuantity += receivedQuantity;

        if (receivedQuantity != Constants.paginationSize) {
          emit(LoadedAllNewsState());
          return;
        }

        emit(SuccessfullyGotNewsState());
      },
    );
  }

  Future<void> _onRefreshNewsEvent(
    NewsEvents event,
    Emitter<AppState> emit,
  ) async {
    news.clear();
    currentQuantity = 0;

    emit(RefreshingNewsState());

    await _onGetNewsEvent(event, emit);
  }
}
