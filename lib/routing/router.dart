import 'package:go_router/go_router.dart';
import '../screens/home.screen.dart';
import '../screens/add_stadium.screen.dart';
import '../screens/stadium.screen.dart';
import '../screens/stadiums.screen.dart';

final GoRouter applicationRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      name:
          'Home', // Optional, add name to your routes. Allows you navigate by name instead of path
      path: '/',
      builder: (context, state) => const Home(),
      routes: [
        GoRoute(
          name:
              'Add Stadiums', // Optional, add name to your routes. Allows you navigate by name instead of path
          path: 'add-stadiums',
          builder: (context, state) => const AddStadium(),
        ),
        GoRoute(
          name:
              'Stadiums', // Optional, add name to your routes. Allows you navigate by name instead of path
          path: 'stadiums',
          builder: (context, state) => const Stadiums(),
          routes: [
            GoRoute(
              name:
                  'Stadium', // Optional, add name to your routes. Allows you navigate by name instead of path
              path: 'stadium/:stadiumId',
              builder: (context, state) => Stadium(state),
            ),
          ],
        ),
      ],
    ),
  ],
);
