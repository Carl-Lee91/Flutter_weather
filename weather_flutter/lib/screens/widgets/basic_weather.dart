import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_flutter/api/api_services.dart';
import 'package:weather_flutter/api/model/weather_api_model.dart';
import 'package:weather_flutter/constant/gaps.dart';
import 'package:weather_flutter/constant/sizes.dart';

class BasicWeather extends StatefulWidget {
  const BasicWeather({
    super.key,
  });

  @override
  State<BasicWeather> createState() => _BasicWeatherState();
}

class _BasicWeatherState extends State<BasicWeather> {
  final oneMinute = const Duration(minutes: 1);
  Future<WeatherModel>? weather;

  double? latitude;
  double? longitude;

  Future<void> _getLocationAndFetchWeather() async {
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.best,
    );
    setState(() {
      latitude = position.latitude;
      longitude = position.longitude;
    });

    weather = ApiService.fetchWeatherInfo(latitude!, longitude!);
  }

  DateTime now = DateTime.now();

  @override
  void initState() {
    super.initState();
    _getLocationAndFetchWeather();

    Timer.periodic(oneMinute, (Timer t) {
      setState(() {
        now = DateTime.now();
      });
      _getLocationAndFetchWeather();
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: weather,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Text(
                    "${now.month}월 ${now.day}일 ${now.hour} : ${now.minute.toString().padLeft(2, '0')}",
                    style: const TextStyle(fontSize: Sizes.size16),
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
                    scale: 1.5,
                  ),
                  Text(
                    snapshot.data!.weather
                        .map((weather) => weather.description)
                        .join(", "),
                    style: const TextStyle(fontSize: Sizes.size32),
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
          );
        }
        return const Text("Loading...");
      },
    );
  }
}
