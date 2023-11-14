import 'package:flutter/material.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("설정"),
      ),
      body: ListView(
        children: const [
          AboutListTile(
            applicationVersion: "1.0.0",
          ),
        ],
      ),
    );
  }
}
