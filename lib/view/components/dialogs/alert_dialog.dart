import 'package:flutter/material.dart';

@immutable
class AlertDialogModel<T> {
  final String title;
  final String content;
  final Map<String, T> action;
  const AlertDialogModel({
    required this.title,
    required this.content,
    required this.action,
  });
}

extension Show<T> on AlertDialogModel<T> {
  Future<T?> show(BuildContext context) => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: action.entries
              .map(
                (entry) => entry.value == true
                    ? FilledButton(
                        onPressed: () => Navigator.of(context).pop(entry.value),
                        child: Text(
                          entry.key,
                        ),
                      )
                    : TextButton(
                        onPressed: () => Navigator.of(context).pop(entry.value),
                        child: Text(
                          entry.key,
                        ),
                      ),
              )
              .toList(),
        ),
      );
}
