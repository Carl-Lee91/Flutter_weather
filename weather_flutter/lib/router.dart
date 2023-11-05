import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:weather_flutter/screens/greetings.dart';
import 'package:weather_flutter/screens/main_navigation/main_navigation.dart';

final routeProvider = Provider(
  (ref) {
    return GoRouter(
      initialLocation: GreetingsScreen.routeUrl,
      routes: [
        GoRoute(
          path: GreetingsScreen.routeUrl,
          name: GreetingsScreen.routeName,
          builder: (context, state) => const GreetingsScreen(),
        ),
        GoRoute(
          path: "/:tab(todayWeather|weekWeather|mapWeather)",
          name: MainNavigation.routeName,
          builder: (context, state) {
            final tab = state.pathParameters["tab"]!;
            return MainNavigation(tab: tab);
          },
        ),
      ],
    );
  },
);
