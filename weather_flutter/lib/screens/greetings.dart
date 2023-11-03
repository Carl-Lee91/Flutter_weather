import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:weather_flutter/constant/sizes.dart';
import 'package:weather_flutter/screens/widgets/button.dart';

class GreetingsScreen extends StatefulWidget {
  static const routeName = "greetings";
  static const routeUrl = "/";
  const GreetingsScreen({super.key});

  @override
  State<GreetingsScreen> createState() => _GreetingsScreenState();
}

class _GreetingsScreenState extends State<GreetingsScreen> {
  Future<void> _requestLocationPermissionAndEnterApp() async {
    PermissionStatus status = await Permission.location.status;
    status = await Permission.location.request();
    if (!mounted) return;
    if (status.isGranted) {
      context.go("/todayWeather");
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text(
              "위치 정보 권한 확인",
            ),
            content: const Text(
              "위치 정보 권한을 허가하여 주십시오.",
            ),
            actions: [
              TextButton(
                onPressed: () async {
                  status = await Permission.location.request();
                  if (!mounted) return;
                  if (status.isGranted) {
                    context.go("/todayWeather");
                  }
                },
                child: const Text(
                  "허가",
                ),
              ),
            ],
          );
        },
      );
    }
  }

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
        child: GestureDetector(
          onTap: _requestLocationPermissionAndEnterApp,
          child: const Button(text: "날씨 알아보기"),
        ),
      ),
    );
  }
}
