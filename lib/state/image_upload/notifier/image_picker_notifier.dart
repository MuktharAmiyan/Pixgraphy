import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pixgraphy/state/image_upload/extention/get_aspect_ratio.dart';
import 'package:pixgraphy/state/image_upload/extention/get_thumbnail.dart';
import 'package:pixgraphy/state/image_upload/helper/image_picker_helper.dart';
import 'package:pixgraphy/state/image_upload/model/image_pick_state.dart';
import 'package:pixgraphy/state/image_upload/model/image_with_thumbnail_and_aspect_ratio.dart';

final imagePickerProvider =
    StateNotifierProvider<ImagePickerNotifier, ImagePickState>(
  (_) => ImagePickerNotifier(),
);

class ImagePickerNotifier extends StateNotifier<ImagePickState> {
  ImagePickerNotifier() : super(const ImagePickState.initial());
  Future<void> pickImage() async {
    ImageWithThumbnailAndAspectRatio? imageWithThumbnailAndAspectRatio;
    state = const ImagePickState.loading();
    final file = await ImagePickerHelper().pickImageFromGallery();
    if (file == null) {
      state = const ImagePickState.initial();
      return;
    }
    final thumbnail = file.getThumbnail;
    if (thumbnail == null) {
      state = const ImagePickState.thumbnailIsNull();
      state = const ImagePickState.initial();
    }

    final fileAsImage = Image.file(file);
    final aspectRatio = await fileAsImage.getAspectRatio;
    imageWithThumbnailAndAspectRatio = ImageWithThumbnailAndAspectRatio(
      image: file,
      tumbnail: thumbnail!,
      aspectRatio: aspectRatio,
    );
    state = ImagePickState.success(
      imageWithThumbnailAndAspectRatio: imageWithThumbnailAndAspectRatio,
    );
  }

  void cancel() {
    state = const ImagePickState.initial();
  }
}
