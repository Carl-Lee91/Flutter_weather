import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:weather_flutter/constant/gaps.dart';

class TodaysWeather extends StatelessWidget {
  const TodaysWeather({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [Text("19C"), Text("일산동"), Gaps.v10, Text("25C / 16C")],
        ),
        Column(
          children: [
            FaIcon(
              FontAwesomeIcons.sun,
            ),
          ],
        ),
      ],
    );
  }
}
