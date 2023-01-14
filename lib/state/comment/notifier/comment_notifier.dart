import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pixgraphy/state/auth/provider/user_id_provider.dart';
import 'package:pixgraphy/state/comment/backend/comment_repository.dart';
import 'package:pixgraphy/state/comment/model/comment_failure.dart';
import 'package:pixgraphy/state/comment/model/comment_state.dart';

final commentProvider =
    StateNotifierProvider<CommentNotifier, CommentState>((ref) {
  final commentRepository = ref.read(commentRepoProvider);
  return CommentNotifier(ref: ref, commentRepository: commentRepository);
});

class CommentNotifier extends StateNotifier<CommentState> {
  final Ref ref;
  final CommentRepository commentRepository;
  CommentNotifier({
    required this.ref,
    required this.commentRepository,
  }) : super(const CommentState.initial());
  Future<void> addComment(
      {required String comment, required String postID}) async {
    state = const CommentState.loading();
    final uid = ref.watch(userIdProvider);
    if (uid == null) {
      state = const CommentState.failure(failure: CommentFailure());
      return;
    }
    final res = await commentRepository.addComment(
      cmttext: comment,
      postID: postID,
      uid: uid,
    );
    state = res.fold(
      (l) => CommentState.failure(failure: l),
      (r) => const CommentState.success(),
    );
  }

  Future<void> deleteComment({required String commentId}) async {
    state = const CommentState.loading();
    final res = await commentRepository.deleteComment(id: commentId);
    state = res.fold(
      (l) => CommentState.failure(failure: l),
      (r) => const CommentState.deleted(),
    );
  }
}
