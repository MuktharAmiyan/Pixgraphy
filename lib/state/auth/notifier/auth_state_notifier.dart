import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pixgraphy/state/auth/backend/auth_repository.dart';
import 'package:pixgraphy/state/auth/model/auth_state.dart';

final authStateProvider =
    StateNotifierProvider<AuthStateNotifier, AuthState>((ref) {
  final authRepo = ref.read(authrepositoryProvider);
  return AuthStateNotifier(authRepo);
});

class AuthStateNotifier extends StateNotifier<AuthState> {
  final AuthRepository authRepo;
  AuthStateNotifier(this.authRepo)
      : super(
          const AuthState.unKnown(),
        ) {
    _init();
  }

  void _init() async {
    final userOrNull = await authRepo.userOrNull();
    if (userOrNull != null) {
      state = AuthState.success(
        uid: userOrNull.uid,
      );
    }
  }

  Future<void> signOut() async {
    state = const AuthState.loading();
    final res = await authRepo.signOut();
    state = res.fold(
      (failure) => AuthState.error(failure: failure),
      (_) => const AuthState.unKnown(),
    );
  }

  Future<void> signInWithEmail({
    required String email,
    required String password,
  }) async {
    state = const AuthState.loading();
    final res = await authRepo.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    state = res.fold(
      (failure) => AuthState.error(failure: failure),
      (uid) => AuthState.success(uid: uid),
    );
  }

  Future<void> signUpWithEmail({
    required String email,
    required String password,
    required String userName,
    required String name,
  }) async {
    state = const AuthState.loading();
    final res = await authRepo.createUserWithEmailAndPassword(
      email: email,
      password: password,
      userName: userName.toLowerCase().replaceAll(' ', ''),
      name: name,
    );
    state = res.fold(
      (failure) => AuthState.error(failure: failure),
      (uid) => AuthState.success(uid: uid),
    );
  }

  Future<void> signInWithGoogle() async {
    state = const AuthState.loading();
    final res = await authRepo.signInWithGoogle();
    state = res.fold(
      (failure) => AuthState.error(failure: failure),
      (uid) => AuthState.success(uid: uid),
    );
  }

  void signInPressed() {
    state = const AuthState.signIn();
  }

  void signUpPressed() {
    state = const AuthState.signUp();
  }
}
