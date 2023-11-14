import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_flutter/screens/today_weather/model/today_air_pollution_api_model.dart';
import 'package:weather_flutter/screens/today_weather/model/today_weather_api_model.dart';
import 'package:weather_flutter/constant/gaps.dart';
import 'package:weather_flutter/constant/sizes.dart';
import 'package:weather_flutter/screens/today_weather/view_model/today_air_pollution_view_model.dart';
import 'package:weather_flutter/screens/today_weather/view_model/today_weather_view_model.dart';
import 'package:weather_flutter/screens/today_weather/widget/weather_condition.dart';
import 'package:weather_flutter/screens/widgets/basic_weather/view/basic_weather.dart';

class TodayWeather extends ConsumerStatefulWidget {
  const TodayWeather({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TodayWeatherState();
}

class _TodayWeatherState extends ConsumerState<TodayWeather> {
  Future<List<DailyWeatherModel>>? dailyWeather;
  Future<AirPollutionModel>? airPollution;

  Future<void> _initDailyWeatherAndAirPollution() async {
    dailyWeather =
        ref.read(dailyWeatherProvider.notifier).fetchDailyWeatherInfo();
    airPollution =
        ref.read(airPollutionProvider.notifier).fetchAirPollutionInfo();
  }

  @override
  void initState() {
    super.initState();
    _initDailyWeatherAndAirPollution();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: Sizes.size12,
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
                    return Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: Sizes.size10,
                        vertical: Sizes.size10,
                      ),
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor.withOpacity(0.05),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height * 0.16,
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
                  return const Text("");
                },
              ),
              Gaps.v40,
              FutureBuilder(
                future: airPollution,
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Text('에러발생: ${snapshot.error}');
                  } else if (snapshot.hasData) {
                    final pm2_5Pollution = snapshot.data!.airPollution
                        .map((airPollution) => airPollution.pm2_5)
                        .join(", ");
                    final pm10Pollution = snapshot.data!.airPollution
                        .map((airPollution) => airPollution.pm10)
                        .join(", ");
                    num pm2_5Num = num.parse(pm2_5Pollution);
                    num pm10Num = num.parse(pm10Pollution);
                    Color pm2_5Color = Colors.white;
                    Color pm10Color = Colors.white;
                    String pm2_5Text = "";
                    String pm10Text = "";
                    if (pm2_5Num <= 10) {
                      pm2_5Color = Colors.blue;
                      pm2_5Text = "최상";
                    } else if (pm2_5Num > 10 && pm2_5Num <= 25) {
                      pm2_5Color = Colors.green;
                      pm2_5Text = "좋음";
                    } else if (pm2_5Num > 25 && pm2_5Num <= 50) {
                      pm2_5Color = Colors.yellow;
                      pm2_5Text = "보통";
                    } else if (pm2_5Num > 50 && pm2_5Num <= 75) {
                      pm2_5Color = Colors.orange;
                      pm2_5Text = "나쁨";
                    } else if (pm2_5Num > 75) {
                      pm2_5Color = Colors.red;
                      pm2_5Text = "최악";
                    }
                    if (pm10Num <= 20) {
                      pm10Color = Colors.blue;
                      pm10Text = "최상";
                    } else if (pm10Num > 20 && pm10Num <= 50) {
                      pm10Color = Colors.green;
                      pm10Text = "좋음";
                    } else if (pm10Num > 50 && pm10Num <= 100) {
                      pm10Color = Colors.yellow;
                      pm10Text = "보통";
                    } else if (pm10Num > 100 && pm10Num <= 200) {
                      pm10Color = Colors.orange;
                      pm10Text = "나쁨";
                    } else if (pm10Num > 200) {
                      pm10Color = Colors.red;
                      pm10Text = "최악";
                    }
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
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            children: [
                              const Text(
                                "미세먼지",
                                style: TextStyle(fontSize: Sizes.size16),
                              ),
                              Gaps.v10,
                              Container(
                                width: 30,
                                height: 30,
                                decoration: BoxDecoration(
                                  color: pm2_5Color,
                                  border: Border.all(
                                    width: 3,
                                    color: Colors.white,
                                  ),
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(
                                      100,
                                    ),
                                  ),
                                ),
                              ),
                              Gaps.v10,
                              Text(
                                "$pm2_5Text ($pm2_5Pollution)",
                                style: const TextStyle(fontSize: Sizes.size16),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              const Text(
                                "초미세먼지",
                                style: TextStyle(fontSize: Sizes.size16),
                              ),
                              Gaps.v10,
                              Container(
                                width: 30,
                                height: 30,
                                decoration: BoxDecoration(
                                  color: pm10Color,
                                  border: Border.all(
                                    width: 3,
                                    color: Colors.white,
                                  ),
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(
                                      100,
                                    ),
                                  ),
                                ),
                              ),
                              Gaps.v10,
                              Text(
                                "$pm10Text ($pm10Pollution)",
                                style: const TextStyle(fontSize: Sizes.size16),
                              ),
                            ],
                          )
                        ],
                      ),
                    );
                  }
                  return const Text("");
                },
              ),
              Gaps.v40,
              const WeatherCondition(),
            ],
          ),
        ),
      ),
    );
  }
}
