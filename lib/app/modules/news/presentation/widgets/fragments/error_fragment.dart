import 'package:flutter/material.dart';
import 'package:unicons/unicons.dart';

class ErrorFragment extends StatelessWidget {
  final void Function() onRefresh;
  final String title;
  final String description;
  final IconData icon;

  const ErrorFragment({
    super.key,
    required this.onRefresh,
    required this.title,
    required this.description,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Icon(icon, size: 70),
            ),
            SizedBox(height: 16),
            Text(
              title,
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              description,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            SizedBox(height: 32),
            ElevatedButton.icon(
              onPressed: onRefresh,
              icon: Icon(
                UniconsLine.refresh,
                color: Theme.of(context).colorScheme.onSurface,
              ),
              label: Text(
                'Reload page',
                style: Theme.of(context).textTheme.labelLarge,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
