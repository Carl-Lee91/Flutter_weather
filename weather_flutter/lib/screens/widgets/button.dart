import 'package:flutter/material.dart';
import 'package:weather_flutter/constant/sizes.dart';

class Button extends StatelessWidget {
  const Button({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 0.5,
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: Sizes.size16,
          horizontal: Sizes.size16,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            Sizes.size5,
          ),
          color: Theme.of(context).primaryColor,
        ),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: Sizes.size16,
          ),
        ),
      ),
    );
  }
}
