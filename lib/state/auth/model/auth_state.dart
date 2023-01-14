import 'package:freezed_annotation/freezed_annotation.dart';

import 'auth_failure.dart';
part 'auth_state.freezed.dart';

@freezed
class AuthState with _$AuthState {
  const factory AuthState.unKnown() = _UnKnown;
  const factory AuthState.loading() = _Loading;
  const factory AuthState.signIn() = _SignIn;
  const factory AuthState.signUp() = _SignUp;
  const factory AuthState.error({
    required AuthFailure failure,
  }) = _Error;
  const factory AuthState.success({
    required String uid,
  }) = _Success;
}
