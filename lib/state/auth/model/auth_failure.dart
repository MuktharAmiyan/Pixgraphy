import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pixgraphy/view/components/constants/strings.dart';
part 'auth_failure.freezed.dart';

@freezed
class AuthFailure with _$AuthFailure {
  const factory AuthFailure.cancelByUser() = _CancelByUser;
  const factory AuthFailure.serverError() = _ServerError;
  const factory AuthFailure.invaliedEmail() = _InvaliedEmail;
  const factory AuthFailure.wrongEmailOrPassword() = _WrongEmailOrPassword;
  const factory AuthFailure.userNotFound() = _UserNotFound;
  const factory AuthFailure.emailAlreadyInUse() = _EmailAlreadyInUse;
  const factory AuthFailure.userDisabled() = _UserDisabled;
  const factory AuthFailure.weakPassword() = _WeakPassword;
}

extension ErrorString on AuthFailure {
  String get toErrString => map(
        cancelByUser: (_) => Strings.cancelByUser,
        serverError: (_) => Strings.serverError,
        invaliedEmail: (_) => Strings.invaliedEmail,
        wrongEmailOrPassword: (_) => Strings.wrongEmailOrPassword,
        userNotFound: (_) => Strings.userNotFound,
        emailAlreadyInUse: (_) => Strings.emailAlreadyInUse,
        userDisabled: (_) => Strings.userDisabled,
        weakPassword: (_) => Strings.weakPassword,
      );
}


  // cancelByUser,
  // serverError,
  // invaliedEmail,
  // wrongEmailOrPassword,
  // userNotFound,
  // emailAlreadyInUse,
  // userDisabled,
  // weakPassword

