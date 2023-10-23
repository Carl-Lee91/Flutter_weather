import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:weather_flutter/constant/sizes.dart';

class TodayWeather extends ConsumerStatefulWidget {
  const TodayWeather({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TodayWeatherState();
}

class _TodayWeatherState extends ConsumerState<TodayWeather> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: Sizes.size28,
            vertical: Sizes.size28,
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Column(
                    children: [
                      FaIcon(
                        FontAwesomeIcons.sun,
                      ),
                    ],
                  ),
                  Column(
                    children: [],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
