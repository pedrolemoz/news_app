import 'package:bloc/bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../../core/domain/errors/global_failures.dart';
import '../../../../../core/external/constants/constants.dart';
import '../../../../../core/presentation/controllers/states/base_states.dart';
import '../../../../../core/presentation/controllers/states/global_states.dart';
import '../../../domain/entities/news.dart';
import '../../../domain/errors/news_failures.dart';
import '../../../domain/parameters/get_news_parameters.dart';
import '../../../domain/usecases/get_news.dart';
import '../events/news_events.dart';
import '../states/news_states.dart';

class NewsBloc extends Bloc<NewsEvents, AppState> implements Disposable {
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
      GetNewsParameters(
        shouldUseLastDocumentReference: news.isNotEmpty,
        lastDocumentReference: news.isNotEmpty ? news.last.reference : null,
      ),
    );

    result.fold(
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

  @override
  void dispose() => close();
}
