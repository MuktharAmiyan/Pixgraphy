import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:pixgraphy/core/firebase/firebase_firestore.dart';
import 'package:pixgraphy/core/firebase/firebase_storage.dart';
import 'package:pixgraphy/state/constant/firebase_const.dart';
import 'package:pixgraphy/state/image_upload/model/storage_failure.dart';
import 'package:pixgraphy/state/post/model/post.dart';

final postUploadRepoProvider = Provider(
  (ref) {
    final firebaseFirestore = ref.read(firebaseFirestoreProvider);
    final storage = ref.read(firebaseStorageProvider);
    return PostUploadRepository(firebaseFirestore, storage);
  },
);

class PostUploadRepository {
  final FirebaseFirestore firebaseFirestore;
  final FirebaseStorage storage;
  PostUploadRepository(this.firebaseFirestore, this.storage);
  Future<Either<StorageFailure, String>> putFile({
    required String id,
    required String reference,
    required File file,
  }) async {
    try {
      final ref = storage.ref(reference).child(id);
      await ref.putFile(file);
      final url = await ref.getDownloadURL();
      return right(url);
    } catch (_) {
      return left(
        const StorageFailure(),
      );
    }
  }

  Future<Either<StorageFailure, String>> putData({
    required String id,
    required String reference,
    required Uint8List data,
  }) async {
    try {
      final ref = storage.ref(reference).child(id);
      await ref.putData(data);
      final url = await ref.getDownloadURL();
      return right(url);
    } catch (_) {
      return left(
        const StorageFailure(),
      );
    }
  }

  Future<Either<StorageFailure, Unit>> uploadPost({required Post post}) async {
    try {
      await firebaseFirestore
          .collection(FirebaseCollectionName.post)
          .doc(post.postId)
          .set(
            post.toMap(),
          );
      return right(unit);
    } catch (_) {
      return left(const StorageFailure());
    }
  }
}
