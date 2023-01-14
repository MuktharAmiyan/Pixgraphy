import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:pixgraphy/core/firebase/firebase_firestore.dart';
import 'package:pixgraphy/state/comment/model/comment.dart';
import 'package:pixgraphy/state/comment/model/comment_failure.dart';
import 'package:pixgraphy/state/constant/firebase_const.dart';
import 'package:uuid/uuid.dart';

final commentRepoProvider = Provider((ref) {
  final firestore = ref.read(firebaseFirestoreProvider);
  return CommentRepository(firestore);
});

class CommentRepository {
  final FirebaseFirestore firebaseFirestore;
  CommentRepository(this.firebaseFirestore);
  Future<Either<CommentFailure, Unit>> addComment({
    required String cmttext,
    required String postID,
    required String uid,
  }) async {
    final id = const Uuid().v1();
    final comment = Comment(
      id: id,
      postId: postID,
      uid: uid,
      comment: cmttext,
      createdAt: DateTime.now(),
    );
    try {
      await firebaseFirestore
          .collection(FirebaseCollectionName.comments)
          .doc(id)
          .set(comment.toMap());
      return right(unit);
    } catch (_) {
      return left(const CommentFailure());
    }
  }

  Future<Either<CommentFailure, Unit>> deleteComment(
      {required String id}) async {
    try {
      await firebaseFirestore
          .collection(FirebaseCollectionName.comments)
          .doc(id)
          .delete();

      return right(unit);
    } catch (_) {
      return left(const CommentFailure());
    }
  }
}
