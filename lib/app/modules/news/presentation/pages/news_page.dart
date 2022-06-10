import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:unicons/unicons.dart';

import '../../../../core/presentation/controllers/states/base_states.dart';
import '../../../../core/presentation/controllers/states/global_states.dart';
import '../controllers/blocs/news_bloc.dart';
import '../controllers/events/news_events.dart';
import '../controllers/states/news_states.dart';
import '../widgets/cards/news_card.dart';
import '../widgets/fragments/error_fragment.dart';
import '../widgets/shimmers/news_card_shimmer.dart';
import '../widgets/skeletons/news_skeleton.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({super.key});

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  final newsBloc = Modular.get<NewsBloc>();
  late ScrollController newsScrollController;

  @override
  void initState() {
    newsBloc.add(GetNewsEvent());
    newsScrollController = ScrollController()
      ..addListener(
        () {
          final position = newsScrollController.position;
          if (position.maxScrollExtent == position.pixels) {
            newsBloc.add(GetNewsEvent());
          }
        },
      );

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();

    newsScrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewsBloc, AppState>(
      bloc: newsBloc,
      builder: (context, state) {
        if (state is GettingInitialNewsState ||
            state is RefreshingNewsState ||
            state is IdleState) {
          return NewsSkeleton(
            child: ListView.separated(
              itemCount: 5,
              separatorBuilder: (_, __) => SizedBox(height: 8),
              padding: const EdgeInsets.all(8),
              itemBuilder: (context, index) => NewsCardShimmer(),
            ),
          );
        }

        if (state is ErrorState) {
          switch (state.runtimeType) {
            case InvalidLastDocumentState:
              return NewsSkeleton(
                child: ErrorFragment(
                  icon: UniconsLine.android_phone_slash,
                  title: 'An internal error occurred',
                  description: 'Pagination has failed',
                  onRefresh: () => newsBloc.add(RefreshNewsEvent()),
                ),
              );
            case NoNewsToShowState:
              return NewsSkeleton(
                child: ErrorFragment(
                  icon: UniconsLine.file_slash,
                  title: 'No news to show',
                  description: 'There are no avaliable news to show',
                  onRefresh: () => newsBloc.add(RefreshNewsEvent()),
                ),
              );
            case NoInternetConnectionState:
              return NewsSkeleton(
                child: ErrorFragment(
                  icon: UniconsLine.wifi_slash,
                  title: 'No internet connection',
                  description: 'Please check your connectivity and try again',
                  onRefresh: () => newsBloc.add(RefreshNewsEvent()),
                ),
              );
            case ServerErrorState:
              return NewsSkeleton(
                child: ErrorFragment(
                  icon: UniconsLine.cloud_slash,
                  title: 'A server error occurred',
                  description: (state as ServerErrorState).message,
                  onRefresh: () => newsBloc.add(RefreshNewsEvent()),
                ),
              );
            default:
              return NewsSkeleton(
                child: ErrorFragment(
                  icon: UniconsLine.exclamation_triangle,
                  title: 'An unknown error occurred',
                  description: (state as UnknownErrorState).message,
                  onRefresh: () => newsBloc.add(RefreshNewsEvent()),
                ),
              );
          }
        }

        return NewsSkeleton(
          child: RefreshIndicator(
            color: Theme.of(context).colorScheme.onSurface,
            onRefresh: () async => newsBloc.add(RefreshNewsEvent()),
            child: ListView.separated(
              controller: newsScrollController,
              itemCount: newsBloc.news.length,
              separatorBuilder: (_, __) => SizedBox(height: 8),
              padding: const EdgeInsets.all(8),
              itemBuilder: (context, index) {
                final news = newsBloc.news.elementAt(index);

                return NewsCard(news: news);
              },
            ),
          ),
        );
      },
    );
  }
}
