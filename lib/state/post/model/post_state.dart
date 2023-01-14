import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pixgraphy/state/post/model/post_failure.dart';
part 'post_state.freezed.dart';

@freezed
class PostState with _$PostState {
  const factory PostState.initial() = _Initial;
  const factory PostState.loading() = _loading;
  const factory PostState.deleted() = _Deleted;
  const factory PostState.failure({
    required PostFailure failure,
  }) = _Failure;
}
