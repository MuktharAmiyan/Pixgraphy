import 'package:pixgraphy/view/components/constants/strings.dart';
import 'package:pixgraphy/view/components/dialogs/alert_dialog.dart';
import 'package:flutter/foundation.dart' show immutable;

@immutable
class DeleteDialog extends AlertDialogModel<bool> {
  const DeleteDialog({
    required String objectName,
  }) : super(
          title: Strings.confirmDelete,
          content: '${Strings.areYouSureYouWantToDelete} $objectName ?',
          action: const {Strings.cancel: false, Strings.delete: true},
        );
}
