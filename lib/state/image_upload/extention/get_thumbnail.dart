import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:image/image.dart';

extension GetThumbnailOrNull on File {
  Uint8List? get getThumbnail {
    final fileAsImage = decodeImage(readAsBytesSync());
    if (fileAsImage == null) {
      return null;
    }
    final thumbanil = copyResize(
      fileAsImage,
      width: 360,
    );
    final thumbnailData = encodeJpg(thumbanil);
    return Uint8List.fromList(thumbnailData);
  }
}
