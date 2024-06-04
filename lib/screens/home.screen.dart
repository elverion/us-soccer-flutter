import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:us_soccer_flutter/modules/stadium/providers/stadium.provider.dart';
import 'package:us_soccer_flutter/widgets/home_card.widget.dart';

class Home extends ConsumerWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
      ),
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 600),
          padding: const EdgeInsets.all(8.0),
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              HomeCard(
                title: 'Add Stadiums',
                description:
                    'Read stadium data from a CSV file containing stadium names and their GPS coordinates.',
                buttonLabel: 'Add Stadiums',
                path: '/add-stadiums',
              ),
              HomeCard(
                title: 'List Stadium',
                description:
                    'Display list of stadiums, with action to view an individual stadium with weather details.',
                buttonLabel: 'Stadiums',
                path: '/stadiums',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
