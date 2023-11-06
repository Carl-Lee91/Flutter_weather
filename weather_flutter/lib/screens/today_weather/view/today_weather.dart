import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_flutter/screens/today_weather/model/daily_weather_api_model.dart';
import 'package:weather_flutter/constant/gaps.dart';
import 'package:weather_flutter/constant/sizes.dart';
import 'package:weather_flutter/screens/today_weather/view_model/today_weather_view_model.dart';
import 'package:weather_flutter/screens/widgets/basic_weather/view/basic_weather.dart';

class TodayWeather extends ConsumerStatefulWidget {
  const TodayWeather({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TodayWeatherState();
}

class _TodayWeatherState extends ConsumerState<TodayWeather> {
  Future<List<DailyWeatherModel>>? dailyWeather;

  Future<void> _initDailyWeather() async {
    dailyWeather =
        ref.read(dailyWeatherProvider.notifier).fetchDailyWeatherInfo();
  }

  @override
  void initState() {
    super.initState();
    _initDailyWeather();
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
            const BasicWeather(),
            Gaps.v40,
            FutureBuilder(
              future: dailyWeather,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Expanded(
                    child: ListView.separated(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          var dailyWeather = snapshot.data![index];
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                  "${dailyWeather.dateTime.split(" ")[1].split(":")[0]}시"),
                              Image.network(
                                "https://openweathermap.org/img/wn/${dailyWeather.weather.map((weather) => weather.icon).join(", ")}@2x.png",
                                scale: 1.5,
                              ),
                              Text(
                                  "${dailyWeather.temp.toStringAsFixed(1).toString()} ℃"),
                            ],
                          );
                        },
                        separatorBuilder: (context, index) => const SizedBox(
                              width: Sizes.size14,
                            ),
                        itemCount: snapshot.data!.length),
                  );
                }
                return const CircularProgressIndicator();
              },
            ),
          ],
        ),
      ),
    );
  }
}
