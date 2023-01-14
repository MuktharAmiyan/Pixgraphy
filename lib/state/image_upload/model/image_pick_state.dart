import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pixgraphy/state/image_upload/model/image_with_thumbnail_and_aspect_ratio.dart';
part 'image_pick_state.freezed.dart';

@freezed
class ImagePickState with _$ImagePickState {
  const factory ImagePickState.initial() = _Initial;
  const factory ImagePickState.loading() = _Loading;
  const factory ImagePickState.thumbnailIsNull() = _ThumbnailIsNull;
  const factory ImagePickState.success({
    required ImageWithThumbnailAndAspectRatio imageWithThumbnailAndAspectRatio,
  }) = _Success;
}
