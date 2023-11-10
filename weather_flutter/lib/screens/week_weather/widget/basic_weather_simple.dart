import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_flutter/screens/widgets/basic_weather/model/basic_weather_api_model.dart';
import 'package:weather_flutter/constant/gaps.dart';
import 'package:weather_flutter/constant/sizes.dart';
import 'package:weather_flutter/screens/widgets/basic_weather/view_model/basic_weather_view_model.dart';

class BasicWeatherSimple extends ConsumerStatefulWidget {
  const BasicWeatherSimple({
    super.key,
  });

  @override
  ConsumerState<BasicWeatherSimple> createState() => _BasicWeatherSimpleState();
}

class _BasicWeatherSimpleState extends ConsumerState<BasicWeatherSimple> {
  Future<BasicWeatherModel>? weather;

  DateTime now = DateTime.now();

  Future<void> _initWeather() async {
    weather = ref.read(basicWeatherProvider.notifier).fetchBasicWeatherInfo();
  }

  @override
  void initState() {
    super.initState();
    _initWeather();
    now = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<BasicWeatherModel>(
      future: weather,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Text('에러발생: ${snapshot.error}');
        } else if (snapshot.hasData) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  Row(
                    children: [
                      Text(
                        "${now.month}월 ${now.day}일 ${now.hour} : ${now.minute.toString().padLeft(2, '0')}",
                        style: const TextStyle(fontSize: Sizes.size14),
                      ),
                    ],
                  ),
                  Gaps.v2,
                  Row(
                    children: [
                      Text(
                        "${snapshot.data!.temp.toStringAsFixed(1).toString()} ℃",
                        style: const TextStyle(fontSize: Sizes.size16),
                      ),
                    ],
                  ),
                ],
              ),
              Gaps.h60,
              Column(
                children: [
                  Image.network(
                    "https://openweathermap.org/img/wn/${snapshot.data!.weather.map((weather) => weather.icon).join(", ")}@2x.png",
                    scale: 1.5,
                  ),
                ],
              ),
            ],
          );
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
