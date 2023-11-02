import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_flutter/api/api_services.dart';
import 'package:weather_flutter/api/model/weather_api_model.dart';
import 'package:weather_flutter/constant/sizes.dart';
import 'package:weather_flutter/screens/widgets/today_weather.dart';

class WeekWeather extends ConsumerStatefulWidget {
  const WeekWeather({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _WeekWeatherState();
}

class _WeekWeatherState extends ConsumerState<WeekWeather> {
  late Future<WeatherModel> weather;

  double lat = 37.67;
  double lon = 126.75;

  @override
  void initState() {
    super.initState();
    weather = ApiService.fetchWeatherInfo(lat, lon);
  }

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
            FutureBuilder(
              future: weather,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Column(
                    children: [Text(snapshot.data!.cityName)],
                  );
                }
                return const Text("...");
              },
            ),
          ],
        ),
      ),
    );
  }
}
