import 'package:flutter/material.dart';
import 'package:pixgraphy/view/components/constants/strings.dart';

class AppLogo extends StatelessWidget {
  final Color? color;
  final double? size;
  const AppLogo({
    super.key,
    this.color,
    this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      Strings.appnameSplit,
      style: Theme.of(context).textTheme.displayMedium!.copyWith(
            fontSize: size,
            fontWeight: FontWeight.bold,
            height: .77,
            color: color ?? Theme.of(context).colorScheme.onBackground,
          ),
    );
  }
}
