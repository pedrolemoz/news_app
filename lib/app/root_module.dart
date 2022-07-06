import 'package:animations/animations.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'domain/usecases/get_news.dart';
import 'external/clients/firebase_firestore_client/firebase_firestore_client.dart';
import 'external/databases/sql_database/configuration/sql_configuration.dart';
import 'external/databases/sql_database/sqflite_database_implementation.dart';
import 'external/datasources/news_datasource_implementation.dart';
import 'external/datasources/news_local_datasource_implementation.dart';
import 'external/services/connectivity_service/connectivity_service.dart';
import 'infrastructure/repositories/news_repository_implementation.dart';
import 'presentation/controllers/blocs/news_bloc.dart';
import 'presentation/pages/news_page.dart';

class RootModule extends Module {
  @override
  List<Bind> get binds => [
        Bind((i) => NewsAppSQLConfiguration()),
        Bind((i) => SQFliteDatabaseImplementation(i())),
        Bind((i) => FirebaseFirestoreClientImplementation()),
        Bind((i) => ConnectivityServiceImplementation()),
        Bind((i) => NewsLocalDataSourceImplementation(i())),
        Bind((i) => NewsDataSourceImplementation(i(), i())),
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
