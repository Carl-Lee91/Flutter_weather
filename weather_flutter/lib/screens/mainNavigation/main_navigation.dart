import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:weather_flutter/screens/mainNavigation/widgets/main_appbar.dart';
import 'package:weather_flutter/screens/mapWeather/map_weather.dart';
import 'package:weather_flutter/screens/today_weather/today_weather.dart';
import 'package:weather_flutter/screens/weekWeather/week_weather.dart';

class MainNavigation extends StatefulWidget {
  static const routeName = "mainNavigation";

  final String tab;

  const MainNavigation({
    super.key,
    required this.tab,
  });

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  final List<String> _tabs = [
    "todayWeather",
    "weekWeather",
    "mapWeather",
  ];

  late int _selectedIndex = _tabs.indexOf(widget.tab);

  void _onTap(int index) {
    context.go("/${_tabs[index]}");
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MainAppBar(),
      body: Stack(
        children: [
          Offstage(
            offstage: _selectedIndex != 0,
            child: const TodayWeather(),
          ),
          Offstage(
            offstage: _selectedIndex != 1,
            child: const WeekWeather(),
          ),
          Offstage(
            offstage: _selectedIndex != 2,
            child: const MapWeather(),
          ),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
        backgroundColor: Theme.of(context).primaryColor,
        indicatorColor: Colors.transparent,
        selectedIndex: _selectedIndex,
        onDestinationSelected: _onTap,
        destinations: const [
          NavigationDestination(
            icon: FaIcon(
              FontAwesomeIcons.sun,
            ),
            label: 'TodayWeather',
          ),
          NavigationDestination(
            icon: FaIcon(
              FontAwesomeIcons.calendar,
            ),
            label: 'WeekWeather',
          ),
          NavigationDestination(
            icon: FaIcon(
              FontAwesomeIcons.mapLocation,
            ),
            label: 'MapWeather',
          ),
        ],
      ),
    );
  }
}
