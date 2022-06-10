import 'package:flutter/material.dart';

class NewsSkeleton extends StatelessWidget {
  final Widget child;

  const NewsSkeleton({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('News')),
      body: SafeArea(
        child: AnimatedSwitcher(
          switchInCurve: Curves.easeIn,
          switchOutCurve: Curves.easeInOut,
          duration: const Duration(milliseconds: 250),
          child: child,
        ),
      ),
    );
  }
}
