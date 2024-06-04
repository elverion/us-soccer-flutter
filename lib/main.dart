import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:us_soccer_flutter/modules/stadium/providers/stadium.provider.dart';
import 'package:us_soccer_flutter/modules/weather/providers/weather.provider.dart';
import 'package:us_soccer_flutter/routing/router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

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
    ref.watch(weatherProvider);

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
          primaryColor: const Color.fromARGB(255, 33, 40, 68),
          secondaryHeaderColor: const Color.fromARGB(255, 179, 25, 66),
          scaffoldBackgroundColor: const Color.fromARGB(255, 225, 225, 225),
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 33, 40, 68),
            primary: const Color.fromARGB(255, 33, 40, 68),
            secondary: const Color.fromARGB(255, 179, 25, 66),
          ),
          useMaterial3: true,
        ),
      ),
    );
  }
}
