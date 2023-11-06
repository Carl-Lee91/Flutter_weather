import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_flutter/constant/gaps.dart';
import 'package:weather_flutter/constant/sizes.dart';
import 'package:weather_flutter/screens/widgets/basic_weather/view/basic_weather.dart';

class WeekWeather extends ConsumerStatefulWidget {
  const WeekWeather({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _WeekWeatherState();
}

class _WeekWeatherState extends ConsumerState<WeekWeather> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: Sizes.size28,
          vertical: Sizes.size28,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BasicWeather(),
            Gaps.v40,
          ],
        ),
      ),
    );
  }
}
