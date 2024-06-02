import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:us_soccer_flutter/modules/location/models/location.model.dart';
import 'package:us_soccer_flutter/modules/stadium/models/stadium.model.dart';
import 'package:us_soccer_flutter/modules/stadium/providers/stadium.provider.dart';
import 'package:us_soccer_flutter/routing/router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // runApp(const MyApp());
  runApp(
    ProviderScope(
      overrides: [
        stadiumProvider.overrideWith(
          (ref) => StadiumProvider(
            ref,
            [],
          ),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class _GlobalWrapper extends ConsumerWidget {
  const _GlobalWrapper({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(stadiumProvider);

    return child;
  }
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return _GlobalWrapper(
      child: MaterialApp.router(
        routerConfig: applicationRouter,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlue),
          useMaterial3: true,
        ),
      ),
    );
  }
}
