import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_flutter/constant/sizes.dart';
import 'package:weather_flutter/screens/widgets/basic_weather/view/basic_weather.dart';

class MapWeather extends ConsumerStatefulWidget {
  const MapWeather({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MapWeatherState();
}

class _MapWeatherState extends ConsumerState<MapWeather> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: Sizes.size28,
            vertical: Sizes.size28,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              BasicWeather(),
            ],
          ),
        ),
      ),
    );
  }
}
