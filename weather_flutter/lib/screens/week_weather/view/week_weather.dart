import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_flutter/screens/week_weather/widget/basic_weather_simple.dart';
import 'package:weather_flutter/screens/widgets/basic_weather/view/basic_weather.dart';

class WeekWeather extends ConsumerStatefulWidget {
  const WeekWeather({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _WeekWeatherState();
}

class _WeekWeatherState extends ConsumerState<WeekWeather> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(toolbarHeight: 0),
          SliverPersistentHeader(
            pinned: true,
            delegate: SimpleWeather(),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [],
            ),
          ),
        ],
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
