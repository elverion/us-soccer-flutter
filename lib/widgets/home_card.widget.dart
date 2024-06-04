import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeCard extends StatelessWidget {
  final String title;
  final String description;
  final String buttonLabel;
  final String path;

  const HomeCard({
    super.key,
    required this.title,
    required this.description,
    required this.buttonLabel,
    required this.path,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      child: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              child: Row(
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Text(description),
            ),
            Row(
              children: [
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () => context.go(path),
                    style: ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll<Color>(
                        Theme.of(context).primaryColor,
                      ),
                      foregroundColor: WidgetStatePropertyAll<Color>(
                        Theme.of(context).colorScheme.onPrimary,
                      ),
                    ),
                    child: Text(buttonLabel),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
