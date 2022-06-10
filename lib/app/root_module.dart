import 'package:animations/animations.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'core/packages/network_connectivity_checker/implementations/network_connectivity_checker_implementation.dart';
import 'core/packages/sql_database/configuration/sql_configuration.dart';
import 'core/packages/sql_database/sqflite_database_implementation.dart';
import 'modules/news/news_module.dart';

class RootModule extends Module {
  @override
  List<Bind> get binds => [
        Bind((i) => NewsAppSQLConfiguration()),
        Bind((i) => SQFliteDatabaseImplementation(i())),
        Bind((i) => NetworkConnectivityCheckerImplementation()),
      ];

  @override
  List<ModularRoute> get routes => [
        ModuleRoute(
          '/',
          module: NewsModule(),
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
