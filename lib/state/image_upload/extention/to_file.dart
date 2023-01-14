import 'dart:io';
import 'package:image_picker/image_picker.dart';

extension ToFile on Future<XFile?> {
  Future<File?> get toFile => then(
        (xFile) => xFile?.path,
      ).then(
        (path) => path != null ? File(path) : null,
      );
}
