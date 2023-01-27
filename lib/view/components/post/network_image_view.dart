import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pixgraphy/view/components/constants/strings.dart';

class NetworkImageView extends StatelessWidget {
  final String url;
  const NetworkImageView(this.url, {super.key});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: url,
      fit: BoxFit.cover,
      progressIndicatorBuilder: (_, url, loadingProgress) {
        return Center(
          child: CircularProgressIndicator(value: loadingProgress.progress),
        );
      },
      errorWidget: (_, __, ___) => Center(
        child: Text(
          Strings.imageErrorMsg,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.titleSmall!.copyWith(
                color: Theme.of(context).colorScheme.onBackground,
              ),
        ),
      ),
    );
  }
}
