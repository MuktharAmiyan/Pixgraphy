import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart' show immutable;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:pixgraphy/core/firebase/firebase_firestore.dart';
import 'package:pixgraphy/core/firebase/firebase_storage.dart';
import 'package:pixgraphy/state/constant/firebase_const.dart';
import 'package:pixgraphy/state/post/model/post_failure.dart';

import '../model/post.dart';

final postRepositoryProvider = Provider((ref) {
  final firebaseFirestore = ref.read(firebaseFirestoreProvider);
  final firebaseStorage = ref.read(firebaseStorageProvider);
  return PostRepository(firebaseFirestore, firebaseStorage);
});

@immutable
class PostRepository {
  final FirebaseFirestore firebaseFirestore;
  final FirebaseStorage firebaseStorage;
  const PostRepository(this.firebaseFirestore, this.firebaseStorage);

  Future<Either<PostFailure, Unit>> deletePost({
    required Post post,
  }) async {
    try {
      //DELETE THUMBNAIL FROM FIREBASE STORAGE
      await firebaseStorage
          .ref()
          .child(FirebaseCollectionName.post)
          .child(post.uid)
          .child(FirebaseCollectionName.thumbnail)
          .child(post.postId)
          .delete();

      // DELETE ORIGINAL POST FROM FIRESTORGAE
      await firebaseStorage
          .ref()
          .child(FirebaseCollectionName.post)
          .child(post.uid)
          .child(FirebaseCollectionName.image)
          .child(post.postId)
          .delete();

      //DELETE POST FROM FIRE STORE
      await _deleteAllDocument(
        postId: post.postId,
        inCollection: FirebaseCollectionName.post,
      );
      // DELETE ALL LIKES FROME FIRESTORE
      await _deleteAllDocument(
        postId: post.postId,
        inCollection: FirebaseCollectionName.likes,
      );
      // DELETE  ALL COMMENTS FROM FIRESTORE
      await _deleteAllDocument(
        postId: post.postId,
        inCollection: FirebaseCollectionName.comments,
      );
      return right(unit);
    } catch (_) {
      return left(const PostFailure());
    }
  }

  Future<void> _deleteAllDocument({
    required String postId,
    required String inCollection,
  }) async {
    await firebaseFirestore.runTransaction(
        maxAttempts: 3,
        timeout: const Duration(seconds: 20), (transaction) async {
      final query = await firebaseFirestore
          .collection(inCollection)
          .where(FirebaseFieldName.postId, isEqualTo: postId)
          .get();

      for (var doc in query.docs) {
        await doc.reference.delete();
      }
    });
  }

  Future<Post> getPostWithId(String postId) async {
    return firebaseFirestore
        .collection(FirebaseCollectionName.post)
        .doc(postId)
        .get()
        .then(
          (doc) => Post.fromMap(
            doc.data()!,
          ),
        );
  }
}
