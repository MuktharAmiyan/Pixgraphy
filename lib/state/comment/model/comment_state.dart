import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pixgraphy/state/comment/model/comment_failure.dart';
part 'comment_state.freezed.dart';

@freezed
class CommentState with _$CommentState {
  const factory CommentState.initial() = _Initial;
  const factory CommentState.failure({
    required CommentFailure failure,
  }) = _failure;
  const factory CommentState.loading() = _Loading;
  const factory CommentState.success() = _Success;
  const factory CommentState.deleted() = _Deleted;
  const factory CommentState.reported() = _Reported;
}
