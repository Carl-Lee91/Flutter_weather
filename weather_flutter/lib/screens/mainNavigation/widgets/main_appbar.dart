import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:weather_flutter/screens/settings/setting_screen.dart';

class MainAppBar extends ConsumerStatefulWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
  const MainAppBar({
    super.key,
  });

  @override
  ConsumerState<MainAppBar> createState() => _MainAppBarState();
}

class _MainAppBarState extends ConsumerState<MainAppBar> {
  void onTapToSettingScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const SettingScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text("날씨"),
      leading: IconButton(
        icon: const FaIcon(FontAwesomeIcons.bars),
        onPressed: () {},
      ),
      actions: [
        IconButton(
          onPressed: onTapToSettingScreen,
          icon: const FaIcon(
            FontAwesomeIcons.gear,
          ),
        ),
      ],
    );
  }
}
