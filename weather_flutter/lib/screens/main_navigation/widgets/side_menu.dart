import 'package:flutter/material.dart';
import 'package:weather_flutter/constant/sizes.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: MediaQuery.of(context).size.width / 1.5,
      child: ListView(
        shrinkWrap: true,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: Sizes.size16,
            ),
            child: SizedBox(
              height: 100,
              child: DrawerHeader(
                child: Image.asset(
                  "assets/picture/main_weather.png",
                ),
              ),
            ),
          ),
          ListTile(
            title: const Text("About"),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
