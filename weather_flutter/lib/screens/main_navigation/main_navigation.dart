import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:weather_flutter/screens/main_navigation/widgets/main_appbar.dart';
import 'package:weather_flutter/screens/main_navigation/widgets/side_menu.dart';
import 'package:weather_flutter/screens/today_weather/view/today_weather.dart';
import 'package:weather_flutter/screens/week_weather/view/week_weather.dart';

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
      drawer: const SideMenu(),
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
            label: '오늘의 날씨',
          ),
          NavigationDestination(
            icon: FaIcon(
              FontAwesomeIcons.calendar,
            ),
            label: '주간 날씨',
          ),
        ],
      ),
    );
  }
}
