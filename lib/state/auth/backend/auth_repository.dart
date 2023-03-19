import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:fpdart/fpdart.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pixgraphy/core/firebase/firebase_auth.dart';
import 'package:pixgraphy/core/firebase/firebase_firestore.dart';
import 'package:pixgraphy/core/firebase/firebase_messaging.dart';
import 'package:pixgraphy/core/firebase/google_sign_in.dart';
import 'package:pixgraphy/state/constant/firebase_const.dart';
import 'package:pixgraphy/state/user_info/model/user_info_model.dart';
import '../model/auth_failure.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authrepositoryProvider = Provider(
  (ref) {
    final firebaseAuth = ref.read(firebaseAuthProvider);
    final firebaseFirestore = ref.read(firebaseFirestoreProvider);
    final googleSignIn = ref.read(googleSignInProvider);
    final firebaseMessaging = ref.read(firebaseMessagingProvider);
    return AuthRepository(
        firebaseAuth, firebaseFirestore, googleSignIn, firebaseMessaging);
  },
);

class AuthRepository {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firestore;
  final GoogleSignIn googleSignIn;
  final FirebaseMessaging messaging;
  AuthRepository(
    this.firebaseAuth,
    this.firestore,
    this.googleSignIn,
    this.messaging,
  );

  Future<Either<AuthFailure, Unit>> signOut() async {
    try {
      final uid = firebaseAuth.currentUser?.uid;
      final token = await _getToken();
      if (uid == null && token == null) {
        return left(const AuthFailure.serverError());
      }
      await firestore.collection(FirebaseCollectionName.users).doc(uid).update({
        FirebaseFieldName.fcmToken: FieldValue.arrayRemove(
          [token],
        ),
      });
      await firebaseAuth.signOut();
      await googleSignIn.signOut();
      return right(unit);
    } catch (_) {
      return left(const AuthFailure.serverError());
    }
  }

  Future<Either<AuthFailure, String>> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      return await firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((
        userCredential,
      ) async {
        final token = await _getToken();
        await firestore
            .collection(FirebaseCollectionName.users)
            .doc(userCredential.user!.uid)
            .update({
          FirebaseFieldName.fcmToken: FieldValue.arrayUnion(
            [token],
          ),
        });

        return right(
          userCredential.user!.uid,
        );
      });
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'invalid-email':
          return left(const AuthFailure.invaliedEmail());
        case 'user-disabled':
          return left(const AuthFailure.userDisabled());
        case 'user-not-found':
          return left(const AuthFailure.wrongEmailOrPassword());
        case 'wrong-password':
          return left(const AuthFailure.wrongEmailOrPassword());
        default:
          return left(const AuthFailure.serverError());
      }
    }
  }

  Future<Either<AuthFailure, String>> createUserWithEmailAndPassword({
    required String email,
    required String password,
    required String userName,
    required String name,
  }) async {
    try {
      return await firebaseAuth
          .createUserWithEmailAndPassword(
        email: email,
        password: password,
      )
          .then((
        userCredential,
      ) async {
        await firebaseAuth.currentUser?.updateDisplayName(
          userName,
        );
        final uid = userCredential.user!.uid;

        final token = await _getToken();
        final userInfoModel = UserInfoModel(
            uid: uid,
            username: userName,
            email: email,
            photoUrl: null,
            name: name,
            fcmToken: [token]);
        await firestore.collection(FirebaseCollectionName.users).doc(uid).set(
              userInfoModel.toMap(),
            );
        return right(uid);
      });
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'email-already-in-use':
          return left(const AuthFailure.emailAlreadyInUse());
        case 'invalid-email':
          return left(const AuthFailure.invaliedEmail());
        case 'weak-password':
          return left(const AuthFailure.weakPassword());
        default:
          return left(const AuthFailure.serverError());
      }
    }
  }

  Future<Either<AuthFailure, String>> signInWithGoogle() async {
    try {
      final googleAccount = await googleSignIn.signIn();
      if (googleAccount == null) {
        return left(const AuthFailure.cancelByUser());
      }
      final googleSignInAuthentication = await googleAccount.authentication;
      final credential = GoogleAuthProvider.credential(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken,
      );

      return await firebaseAuth.signInWithCredential(credential).then(
        (userCredential) async {
          final token = await _getToken();
          final uid = userCredential.user!.uid;
          final name = userCredential.user?.displayName;
          final userName = userCredential.user!.displayName!
              .toLowerCase()
              .replaceAll(' ', '');
          final photoUrl = userCredential.user?.photoURL;
          final email = userCredential.user?.email;
          //CHECK FOR USER IS ALREADY SAVED IN FIRESTORE
          final userDoc = await firestore
              .collection(FirebaseCollectionName.users)
              .where(FirebaseFieldName.uid, isEqualTo: uid)
              .limit(1)
              .get();
          if (userDoc.docs.isNotEmpty) {
            await firestore
                .collection(FirebaseCollectionName.users)
                .doc(uid)
                .update(
              {
                FirebaseFieldName.fcmToken: FieldValue.arrayUnion(
                  [token],
                ),
              },
            );
            return right(uid);
          }
          final userInfo = UserInfoModel(
            uid: uid,
            username: userName,
            email: email ?? '',
            photoUrl: photoUrl,
            name: name ?? '',
            fcmToken: [token],
          );
          await firestore.collection(FirebaseCollectionName.users).doc(uid).set(
                userInfo.toMap(),
              );

          return right(uid);
        },
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-disabled') {
        return left(const AuthFailure.userDisabled());
      }
      return left(const AuthFailure.serverError());
    }
  }

  Future<User?> userOrNull() async {
    return firebaseAuth.currentUser;
  }

  Future<String?> _getToken() async {
    return await messaging.getToken();
  }
}
