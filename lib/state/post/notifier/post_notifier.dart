import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pixgraphy/state/post/backend/post_repository.dart';
import 'package:pixgraphy/state/post/model/post.dart';
import 'package:pixgraphy/state/post/model/post_state.dart';

final postProvider = StateNotifierProvider<PostNotifier, PostState>((ref) {
  final postRepository = ref.read(postRepositoryProvider);
  return PostNotifier(postRepository);
});

class PostNotifier extends StateNotifier<PostState> {
  final PostRepository postRepository;
  PostNotifier(this.postRepository) : super(const PostState.initial());

  Future<void> deletePost({required Post post}) async {
    state = const PostState.loading();
    final res = await postRepository.deletePost(post: post);
    state = res.fold(
      (f) => PostState.failure(failure: f),
      (_) => const PostState.deleted(),
    );
  }
}
