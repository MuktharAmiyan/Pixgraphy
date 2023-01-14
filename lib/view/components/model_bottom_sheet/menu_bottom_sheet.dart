import 'package:flutter/material.dart';

void showMenuBottomSheet({
  required BuildContext context,
  required Widget child,
}) =>
    showModalBottomSheet(
      context: context,
      elevation: 1,
      enableDrag: true,
      backgroundColor: Theme.of(context).colorScheme.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(28),
        ),
      ),
      clipBehavior: Clip.antiAlias,
      builder: (context) => DraggableScrollableSheet(
        maxChildSize: .8,
        initialChildSize: .4,
        expand: false,
        builder: (context, scrollController) => ListView(
          controller: scrollController,
          clipBehavior: Clip.antiAlias,
          children: [
            Center(
              child: Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.only(top: 12, bottom: 24),
                height: 4,
                width: 32,
                color: Theme.of(context)
                    .colorScheme
                    .onSurfaceVariant
                    .withOpacity(0.4),
              ),
            ),
            child
          ],
        ),
      ),
    );
