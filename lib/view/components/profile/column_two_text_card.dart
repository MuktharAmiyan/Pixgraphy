import 'package:flutter/material.dart';

class ColumnTwoTextCard extends StatelessWidget {
  final String? title;
  final Icon? icon;
  final String subTitle;
  final VoidCallback? onTap;
  const ColumnTwoTextCard({
    super.key,
    this.title,
    this.icon,
    required this.subTitle,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (title != null) ...[
          Text(
            title!,
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.surface,
                ),
          ),
        ] else if (icon != null) ...[
          icon!
        ],
        Text(
          subTitle,
          style: Theme.of(context).textTheme.titleSmall!.copyWith(
                color: Theme.of(context).colorScheme.surface,
              ),
        ),
      ],
    );
  }
}
