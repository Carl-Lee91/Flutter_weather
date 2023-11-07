import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:weather_flutter/screens/widgets/basic_weather/model/basic_weather_api_model.dart';
import 'package:weather_flutter/constant/gaps.dart';
import 'package:weather_flutter/constant/sizes.dart';
import 'package:weather_flutter/screens/widgets/basic_weather/view_model/basic_weather_view_model.dart';

class BasicWeather extends ConsumerStatefulWidget {
  const BasicWeather({
    super.key,
  });

  @override
  ConsumerState<BasicWeather> createState() => _BasicWeatherState();
}

class _BasicWeatherState extends ConsumerState<BasicWeather> {
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

  Future<void> _refreshTimeAndWeather() async {
    setState(() {
      _initWeather();
      now = DateTime.now();
    });
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
          return Container(
            padding: const EdgeInsets.symmetric(
              horizontal: Sizes.size10,
              vertical: Sizes.size8,
            ),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor.withOpacity(0.05),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          "${now.month}월 ${now.day}일 ${now.hour} : ${now.minute.toString().padLeft(2, '0')}",
                          style: const TextStyle(fontSize: Sizes.size16),
                        ),
                        IconButton(
                          onPressed: _refreshTimeAndWeather,
                          icon: const FaIcon(
                            FontAwesomeIcons.arrowsRotate,
                            size: Sizes.size16,
                          ),
                        )
                      ],
                    ),
                    Gaps.v10,
                    Row(
                      children: [
                        Text(
                          "${snapshot.data!.temp.toStringAsFixed(1).toString()} ℃",
                          style: const TextStyle(fontSize: Sizes.size32),
                        ),
                      ],
                    ),
                    Gaps.v10,
                    Text(
                      snapshot.data!.cityName,
                      style: const TextStyle(fontSize: Sizes.size20),
                    ),
                    Gaps.v10,
                    Text(
                      "${snapshot.data!.maxTemp.toStringAsFixed(1).toString()} ℃ / ${snapshot.data!.minTemp.toStringAsFixed(1).toString()} ℃",
                      style: const TextStyle(fontSize: Sizes.size16),
                    ),
                    Text(
                      "체감온도 ${snapshot.data!.feelTemp.toStringAsFixed(1).toString()} ℃",
                      style: const TextStyle(fontSize: Sizes.size16),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Image.network(
                      "https://openweathermap.org/img/wn/${snapshot.data!.weather.map((weather) => weather.icon).join(", ")}@2x.png",
                      scale: 1.2,
                    ),
                    Text(
                      snapshot.data!.weather
                          .map((weather) => weather.description)
                          .join(", "),
                      style: const TextStyle(fontSize: Sizes.size20),
                    ),
                    Gaps.v10,
                    Text(
                      "습도 ${snapshot.data!.humidity.toStringAsFixed(1).toString()} %",
                      style: const TextStyle(fontSize: Sizes.size16),
                    ),
                    Text(
                      "풍속 ${snapshot.data!.windSpeed.toStringAsFixed(1).toString()} m/s",
                      style: const TextStyle(fontSize: Sizes.size16),
                    ),
                  ],
                ),
              ],
            ),
          );
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
