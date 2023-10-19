import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:weather_flutter/constant/sizes.dart';
import 'package:weather_flutter/screens/widgets/button.dart';

class GreetingsScreen extends StatelessWidget {
  static const routeName = "greetings";
  static const routeUrl = "/";
  const GreetingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    void _onEnterAppTab() {
      context.go("/todayWeather");
    }

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Image.asset(
              "assets/picture/main_weather.png",
              width: 300,
              height: 300,
            ),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(vertical: Sizes.size16),
        child: GestureDetector(
          onTap: _onEnterAppTab,
          child: const Button(text: "날씨 알아보기"),
        ),
      ),
    );
  }
}
