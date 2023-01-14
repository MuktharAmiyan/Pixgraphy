import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pixgraphy/state/auth/provider/user_id_provider.dart';
import 'package:pixgraphy/state/constant/firebase_const.dart';
import 'package:pixgraphy/state/image_upload/backend/post_upload_repository.dart';
import 'package:pixgraphy/state/image_upload/model/image_with_thumbnail_and_aspect_ratio.dart';
import 'package:pixgraphy/state/image_upload/model/post_upload_state.dart';
import 'package:pixgraphy/state/post/model/post.dart';
import 'package:uuid/uuid.dart';

final postUploadProvider =
    StateNotifierProvider<PostUploadNotifier, PostUploadState>((ref) {
  final postUploadRepo = ref.read(postUploadRepoProvider);
  return PostUploadNotifier(postUploadRepo, ref);
});

class PostUploadNotifier extends StateNotifier<PostUploadState> {
  final PostUploadRepository _postUploadRepository;
  final Ref ref;
  PostUploadNotifier(
    this._postUploadRepository,
    this.ref,
  ) : super(
          const PostUploadState.initial(),
        );

  Future<void> upload({
    required ImageWithThumbnailAndAspectRatio allImage,
    required String title,
    required String shotOn,
    required String description,
  }) async {
    state = const PostUploadState.loading();
    //POST ID GENERATED USING UUID PACKAGE
    final uid = ref.read(userIdProvider);
    if (uid == null) {
      state = const PostUploadState.failed();
      return;
    }
    final postId = const Uuid().v4();
    String? url;
    String? thumbnailUrl;
    //POST IMAGE REF
    final postImageRef =
        '${FirebaseCollectionName.post}/$uid/${FirebaseCollectionName.image}';
    final postThumbnailRef =
        '${FirebaseCollectionName.post}/$uid/${FirebaseCollectionName.thumbnail}';
    //UPLOAD ORIGINAL IMAGE
    final imageRes = await _postUploadRepository.putFile(
      id: postId,
      reference: postImageRef,
      file: allImage.image,
    );
    imageRes.fold(
      (fail) {
        state = const PostUploadState.failed();
      },
      (s) {
        url = s;
      },
    );
    //UPLOAD  THUMBNAIL
    final thumbnailRes = await _postUploadRepository.putData(
      id: postId,
      reference: postThumbnailRef,
      data: allImage.tumbnail,
    );
    thumbnailRes.fold((fail) {
      state = const PostUploadState.failed();
    }, (s) {
      thumbnailUrl = s;
    });

    // CHECKING FOR BOTH ULPADING STATE ARE FAILURE THEN RETUN NULL
    if (imageRes.isLeft() && thumbnailRes.isLeft()) {
      return;
    }

    final post = Post(
      postId: postId,
      uid: uid,
      url: url!,
      thumbnailUrl: thumbnailUrl!,
      aspectRatio: allImage.aspectRatio,
      createdAt: DateTime.now(),
      title: title.isEmpty ? null : title,
      shotOn: shotOn.isEmpty ? null : shotOn,
      description: description.isEmpty ? null : description,
    );

    final postUploadRes = await _postUploadRepository.uploadPost(
      post: post,
    );
    state = postUploadRes.fold(
      (l) => const PostUploadState.failed(),
      (r) => const PostUploadState.success(),
    );
  }
}
