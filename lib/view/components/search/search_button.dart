import 'package:flutter/material.dart';

class SearchButton extends StatelessWidget {
  final String hintText;
  final VoidCallback onTap;
  const SearchButton({required this.hintText, required this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: Theme.of(context).colorScheme.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(56),
        ),
        elevation: 0.5,
        child: Container(
          constraints: const BoxConstraints(minWidth: 360, maxWidth: 760),
          height: 56,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.search_outlined,
                color: Theme.of(context).colorScheme.onSurface,
              ),
              const SizedBox(
                width: 16,
              ),
              Text(
                hintText,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
