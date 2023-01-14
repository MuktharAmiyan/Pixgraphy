import 'package:freezed_annotation/freezed_annotation.dart';
part 'post_upload_state.freezed.dart';

@freezed
class PostUploadState with _$PostUploadState {
  const factory PostUploadState.initial() = _Initial;
  const factory PostUploadState.loading() = _Loading;
  const factory PostUploadState.success() = _Success;
  const factory PostUploadState.failed() = _Failed;
}
