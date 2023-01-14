import 'dart:io';

import 'package:flutter/foundation.dart' show immutable, Uint8List;

@immutable
class ImageWithThumbnailAndAspectRatio {
  final File image;
  final Uint8List tumbnail;
  final double aspectRatio;
  const ImageWithThumbnailAndAspectRatio({
    required this.image,
    required this.tumbnail,
    required this.aspectRatio,
  });
}
