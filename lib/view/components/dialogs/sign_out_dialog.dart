import 'package:flutter/foundation.dart' show immutable;
import 'package:pixgraphy/view/components/constants/strings.dart';
import 'package:pixgraphy/view/components/dialogs/alert_dialog.dart';

@immutable
class SignOutDialog extends AlertDialogModel<bool> {
  const SignOutDialog({
    super.title = Strings.signingOut,
    super.content = Strings.areYouSureYouWantToSignOut,
    super.action = const {Strings.cancel: false, Strings.ok: true},
  });
}
