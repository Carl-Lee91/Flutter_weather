import 'package:flutter/material.dart';
import 'package:weather_flutter/constant/sizes.dart';
import 'package:weather_flutter/screens/widgets/button.dart';

class GreetingsScreen extends StatelessWidget {
  static const routeName = "greetings";
  static const routeUrl = "/";
  const GreetingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
        child:
            GestureDetector(onTap: () {}, child: const Button(text: "날씨 알아보기")),
      ),
    );
  }
}
