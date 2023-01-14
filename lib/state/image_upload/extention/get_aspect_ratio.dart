import 'dart:async';

import 'package:flutter/material.dart' as material;

extension GetAspectRatio on material.Image {
  Future<double> get getAspectRatio {
    final completer = Completer<double>();
    image.resolve(const material.ImageConfiguration()).addListener(
      material.ImageStreamListener(
        (
          imageInfo,
          synchronousCall,
        ) {
          final aspectratio = imageInfo.image.width / imageInfo.image.height;
          imageInfo.dispose();
          completer.complete(aspectratio);
        },
      ),
    );
    return completer.future;
  }
}
