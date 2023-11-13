import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:weather_flutter/constant/gaps.dart';
import 'package:weather_flutter/constant/sizes.dart';
import 'package:weather_flutter/screens/week_weather/model/week_weather_model.dart';
import 'package:weather_flutter/screens/week_weather/view_model/week_weather_view_model.dart';
import 'package:weather_flutter/screens/week_weather/widget/basic_weather_simple.dart';
import 'package:weather_flutter/screens/widgets/basic_weather/view/basic_weather.dart';

class WeekWeather extends ConsumerStatefulWidget {
  const WeekWeather({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _WeekWeatherState();
}

class _WeekWeatherState extends ConsumerState<WeekWeather> {
  Future<List<WeekWeatherModel>>? weekWeather;

  Future<void> _initWeekWeather() async {
    weekWeather = ref.read(weekWeatherProvider.notifier).fetchWeekWeatherInfo();
  }

  @override
  void initState() {
    super.initState();
    _initWeekWeather();
  }

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    DateTime second = now.add(const Duration(days: 1));
    DateTime third = second.add(const Duration(days: 1));
    DateTime fourth = third.add(const Duration(days: 1));
    DateTime fifth = fourth.add(const Duration(days: 1));
    DateTime sixth = fifth.add(const Duration(days: 1));
    DateTime seventh = sixth.add(const Duration(days: 1));
    DateTime eighth = seventh.add(const Duration(days: 1));

    String formattedNow = DateFormat("MM/dd").format(now);
    String formattedSecond = DateFormat("MM/dd").format(second);
    String formattedThird = DateFormat("MM/dd").format(third);
    String formattedFourth = DateFormat("MM/dd").format(fourth);
    String formattedFifth = DateFormat("MM/dd").format(fifth);
    String formattedSixth = DateFormat("MM/dd").format(sixth);
    String formattedSeventh = DateFormat("MM/dd").format(seventh);
    String formattedEighth = DateFormat("MM/dd").format(eighth);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: Sizes.size12,
          vertical: Sizes.size28,
        ),
        child: CustomScrollView(
          slivers: [
            const SliverAppBar(toolbarHeight: 0),
            SliverPersistentHeader(
              pinned: true,
              delegate: SimpleWeather(),
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  FutureBuilder(
                    future: weekWeather,
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Text('에러발생: ${snapshot.error}');
                      } else if (snapshot.hasData) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: Sizes.size28,
                          ),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: Sizes.size10,
                              vertical: Sizes.size10,
                            ),
                            decoration: BoxDecoration(
                              color: Theme.of(context)
                                  .primaryColor
                                  .withOpacity(0.05),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: Sizes.size14,
                                vertical: Sizes.size28,
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(formattedNow),
                                      Text(
                                        "${snapshot.data![0].temp!.toStringAsFixed(1).toString()} ℃",
                                        style: const TextStyle(
                                          fontSize: Sizes.size24,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Image.network(
                                        "https://openweathermap.org/img/wn/${snapshot.data![0].weather.map((weather) => weather.icon).join(", ")}@2x.png",
                                        width: 80,
                                        height: 80,
                                      ),
                                      Text(
                                          "${snapshot.data![0].minTemp!.toStringAsFixed(1).toString()} ℃ / ${snapshot.data![0].maxTemp!.toStringAsFixed(1).toString()} ℃"),
                                    ],
                                  ),
                                  Gaps.v16,
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(formattedSecond),
                                      Text(
                                        "${snapshot.data![1].temp!.toStringAsFixed(1).toString()} ℃",
                                        style: const TextStyle(
                                          fontSize: Sizes.size24,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Image.network(
                                        "https://openweathermap.org/img/wn/${snapshot.data![1].weather.map((weather) => weather.icon).join(", ")}@2x.png",
                                        width: 80,
                                        height: 80,
                                      ),
                                      Text(
                                          "${snapshot.data![1].minTemp!.toStringAsFixed(1).toString()} ℃ / ${snapshot.data![1].maxTemp!.toStringAsFixed(1).toString()} ℃"),
                                    ],
                                  ),
                                  Gaps.v16,
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(formattedThird),
                                      Text(
                                        "${snapshot.data![2].temp!.toStringAsFixed(1).toString()} ℃",
                                        style: const TextStyle(
                                          fontSize: Sizes.size24,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Image.network(
                                        "https://openweathermap.org/img/wn/${snapshot.data![2].weather.map((weather) => weather.icon).join(", ")}@2x.png",
                                        width: 80,
                                        height: 80,
                                      ),
                                      Text(
                                          "${snapshot.data![2].minTemp!.toStringAsFixed(1).toString()} ℃ / ${snapshot.data![2].maxTemp!.toStringAsFixed(1).toString()} ℃"),
                                    ],
                                  ),
                                  Gaps.v16,
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(formattedFourth),
                                      Text(
                                        "${snapshot.data![3].temp!.toStringAsFixed(1).toString()} ℃",
                                        style: const TextStyle(
                                          fontSize: Sizes.size24,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Image.network(
                                        "https://openweathermap.org/img/wn/${snapshot.data![3].weather.map((weather) => weather.icon).join(", ")}@2x.png",
                                        width: 80,
                                        height: 80,
                                      ),
                                      Text(
                                          "${snapshot.data![3].minTemp!.toStringAsFixed(1).toString()} ℃ / ${snapshot.data![3].maxTemp!.toStringAsFixed(1).toString()} ℃"),
                                    ],
                                  ),
                                  Gaps.v16,
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(formattedFifth),
                                      Text(
                                        "${snapshot.data![4].temp!.toStringAsFixed(1).toString()} ℃",
                                        style: const TextStyle(
                                          fontSize: Sizes.size24,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Image.network(
                                        "https://openweathermap.org/img/wn/${snapshot.data![4].weather.map((weather) => weather.icon).join(", ")}@2x.png",
                                        width: 80,
                                        height: 80,
                                      ),
                                      Text(
                                          "${snapshot.data![4].minTemp!.toStringAsFixed(1).toString()} ℃ / ${snapshot.data![4].maxTemp!.toStringAsFixed(1).toString()} ℃"),
                                    ],
                                  ),
                                  Gaps.v16,
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(formattedSixth),
                                      Text(
                                        "${snapshot.data![5].temp!.toStringAsFixed(1).toString()} ℃",
                                        style: const TextStyle(
                                          fontSize: Sizes.size24,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Image.network(
                                        "https://openweathermap.org/img/wn/${snapshot.data![5].weather.map((weather) => weather.icon).join(", ")}@2x.png",
                                        width: 80,
                                        height: 80,
                                      ),
                                      Text(
                                          "${snapshot.data![5].minTemp!.toStringAsFixed(1).toString()} ℃ / ${snapshot.data![5].maxTemp!.toStringAsFixed(1).toString()} ℃"),
                                    ],
                                  ),
                                  Gaps.v16,
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(formattedSeventh),
                                      Text(
                                        "${snapshot.data![6].temp!.toStringAsFixed(1).toString()} ℃",
                                        style: const TextStyle(
                                          fontSize: Sizes.size24,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Image.network(
                                        "https://openweathermap.org/img/wn/${snapshot.data![6].weather.map((weather) => weather.icon).join(", ")}@2x.png",
                                        width: 80,
                                        height: 80,
                                      ),
                                      Text(
                                          "${snapshot.data![6].minTemp!.toStringAsFixed(1).toString()} ℃ / ${snapshot.data![6].maxTemp!.toStringAsFixed(1).toString()} ℃"),
                                    ],
                                  ),
                                  Gaps.v16,
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(formattedEighth),
                                      Text(
                                        "${snapshot.data![7].temp!.toStringAsFixed(1).toString()} ℃",
                                        style: const TextStyle(
                                          fontSize: Sizes.size24,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Image.network(
                                        "https://openweathermap.org/img/wn/${snapshot.data![7].weather.map((weather) => weather.icon).join(", ")}@2x.png",
                                        width: 80,
                                        height: 80,
                                      ),
                                      Text(
                                          "${snapshot.data![7].minTemp!.toStringAsFixed(1).toString()} ℃ / ${snapshot.data![7].maxTemp!.toStringAsFixed(1).toString()} ℃"),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }
                      return const Text("");
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SimpleWeather extends SliverPersistentHeaderDelegate {
  @override
  double get minExtent => 70.0;

  @override
  double get maxExtent => 201.0;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    if (shrinkOffset == 0) {
      return Center(
        child: Container(
          color: Colors.grey.shade800,
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              BasicWeather(),
            ],
          ),
        ),
      );
    } else {
      return Center(
        child: Container(
          color: Colors.grey.shade800,
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              BasicWeatherSimple(),
            ],
          ),
        ),
      );
    }
  }

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
