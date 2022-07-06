import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class EntryPoint extends StatelessWidget {
  const EntryPoint({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routeInformationParser: Modular.routeInformationParser,
      routerDelegate: Modular.routerDelegate,
      theme: ThemeData.dark().copyWith(useMaterial3: true),
      title: 'News App',
      debugShowCheckedModeBanner: false,
    );
  }
}
