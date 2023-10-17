import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:weather_flutter/screens/greetings.dart';

final routeProvider = Provider(
  (ref) {
    return GoRouter(
      initialLocation: GreetingsScreen.routeUrl,
      routes: [
        GoRoute(
          path: GreetingsScreen.routeUrl,
          name: GreetingsScreen.routeName,
          builder: (context, state) => const GreetingsScreen(),
        )
      ],
    );
  },
);
