import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_flutter/constant/sizes.dart';
import 'package:weather_flutter/screens/widgets/today_weather.dart';

class TodayWeather extends ConsumerStatefulWidget {
  const TodayWeather({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TodayWeatherState();
}

class _TodayWeatherState extends ConsumerState<TodayWeather> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: Sizes.size28,
          vertical: Sizes.size28,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const TodaysWeather(),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: Sizes.size48,
              ),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: Sizes.size10,
                    vertical: Sizes.size8,
                  ),
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: 200,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(
                        Sizes.size16,
                      ),
                    ),
                    shape: BoxShape.rectangle,
                    color: const Color(0xFF2BB6F6).withAlpha(75),
                  ),
                  child: LineChart(
                    LineChartData(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
