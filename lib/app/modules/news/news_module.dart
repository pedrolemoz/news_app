import 'package:animations/animations.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../core/packages/firebase/firebase_firestore_client/implementation/firebase_firestore_client_implementation.dart';
import 'domain/usecases/get_news.dart';
import 'external/datasources/news_datasource_implementation.dart';
import 'external/datasources/news_local_datasource_implementation.dart';
import 'infrastructure/repositories/news_repository_implementation.dart';
import 'presentation/controllers/blocs/news_bloc.dart';
import 'presentation/pages/news_page.dart';

class NewsModule extends Module {
  @override
  List<Bind> get binds => [
        Bind((i) => FirebaseFirestoreClientImplementation()),
        Bind((i) => NewsDataSourceImplementation(i(), i())),
        Bind((i) => NewsLocalDataSourceImplementation(i())),
        Bind((i) => NewsRepositoryImplementation(i(), i())),
        Bind((i) => GetNewsImplementation(i())),
        Bind((i) => NewsBloc(i())),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          '/',
          child: (_, __) => NewsPage(),
          transition: TransitionType.custom,
          customTransition: CustomTransition(
            transitionDuration: const Duration(milliseconds: 400),
            transitionBuilder: (context, animation, secondaryAnimation, child) {
              return FadeThroughTransition(
                animation: animation,
                secondaryAnimation: secondaryAnimation,
                child: child,
              );
            },
          ),
        ),
      ];
}
