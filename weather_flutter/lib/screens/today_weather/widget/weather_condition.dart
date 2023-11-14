import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'package:weather_flutter/constant/gaps.dart';
import 'package:weather_flutter/constant/sizes.dart';
import 'package:weather_flutter/screens/widgets/basic_weather/model/basic_weather_api_model.dart';
import 'package:weather_flutter/screens/widgets/basic_weather/view_model/basic_weather_view_model.dart';

class WeatherCondition extends ConsumerStatefulWidget {
  const WeatherCondition({
    super.key,
  });

  @override
  ConsumerState<WeatherCondition> createState() => _WeatherConditionState();
}

class _WeatherConditionState extends ConsumerState<WeatherCondition> {
  Future<BasicWeatherModel>? weather;

  Future<void> _initWeather() async {
    weather = ref.read(basicWeatherProvider.notifier).fetchBasicWeatherInfo();
  }

  @override
  void initState() {
    super.initState();
    _initWeather();
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
          DateTime sunrise = DateTime.fromMillisecondsSinceEpoch(
              snapshot.data!.sunrise.toInt() * 1000,
              isUtc: true);
          DateTime sunset = DateTime.fromMillisecondsSinceEpoch(
              snapshot.data!.sunset.toInt() * 1000,
              isUtc: true);
          String formattedSunrise =
              DateFormat("HH:mm").format(sunrise.toLocal());
          String formattedSunset = DateFormat("HH:mm").format(sunset.toLocal());
          return Column(
            children: [
              Column(
                children: [
                  SleekCircularSlider(
                    initialValue: snapshot.data!.humidity.toDouble(),
                    appearance: CircularSliderAppearance(
                      animationEnabled: true,
                      infoProperties: InfoProperties(
                        mainLabelStyle: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: Sizes.size32,
                        ),
                        bottomLabelText: "습도",
                        bottomLabelStyle: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: Sizes.size18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      customColors: CustomSliderColors(
                        hideShadow: true,
                        progressBarColor: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
              Gaps.v20,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      const Text(
                        "일출",
                        style: TextStyle(
                          fontSize: Sizes.size28,
                        ),
                      ),
                      Gaps.v10,
                      const Text(
                        "🌞",
                        style: TextStyle(
                          fontSize: Sizes.size72,
                        ),
                      ),
                      Gaps.v10,
                      Text(
                        formattedSunrise,
                        style: const TextStyle(
                          fontSize: Sizes.size28,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      const Text(
                        "일몰",
                        style: TextStyle(
                          fontSize: Sizes.size28,
                        ),
                      ),
                      Gaps.v10,
                      const Text(
                        "🌛",
                        style: TextStyle(
                          fontSize: Sizes.size72,
                        ),
                      ),
                      Gaps.v10,
                      Text(
                        formattedSunset,
                        style: const TextStyle(
                          fontSize: Sizes.size28,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          );
        }
        return const Text("");
      },
    );
  }
}
