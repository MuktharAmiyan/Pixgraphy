import 'dart:io';

import 'package:flutter/foundation.dart' show immutable;
import 'package:image_picker/image_picker.dart';
import 'package:pixgraphy/state/image_upload/extention/to_file.dart';

@immutable
class ImagePickerHelper {
  static final _imagePicker = ImagePicker();
  Future<File?> pickImageFromGallery() =>
      _imagePicker.pickImage(source: ImageSource.gallery).toFile;
}
