import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pixgraphy/route/route_const.dart';
import 'package:pixgraphy/state/auth/provider/user_id_provider.dart';
import 'package:pixgraphy/state/comment/model/comment.dart';
import 'package:pixgraphy/state/constant/firebase_const.dart';
import 'package:pixgraphy/state/date/extension/date_format.dart';
import 'package:pixgraphy/state/report/model/report_type.dart';
import 'package:pixgraphy/view/components/constants/strings.dart';
import 'package:pixgraphy/view/components/dialogs/alert_dialog.dart';
import 'package:pixgraphy/view/components/dialogs/delete_dialog.dart';
import 'package:pixgraphy/view/components/model_bottom_sheet/menu_bottom_sheet.dart';
import 'package:pixgraphy/view/components/profile/profile_circle_avathar.dart';
import 'package:pixgraphy/view/components/text/subtitle.dart';

import '../../../state/comment/notifier/comment_notifier.dart';
import 'comment_username_comment_text.dart';

class CommentTile extends ConsumerWidget {
  final String uid;
  final Comment comment;
  final DateTime date;
  final bool isTraling;
  const CommentTile(
      {super.key,
      required this.uid,
      required this.comment,
      required this.date,
      this.isTraling = true});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUid = ref.watch(userIdProvider);

    return ListTile(
      leading: ProfileCircleAvatar(
        uid: uid,
        onTap: () => context.pushNamed(RouteName.profile,
            pathParameters: {FirebaseFieldName.uid: uid}),
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CommentUsernameAndComment(uid: uid, comment: comment.comment),
          const SizedBox(
            height: 5,
          ),
          SubTitleWidget(text: date.format()),
        ],
      ),
      trailing: isTraling
          ? IconButton(
              onPressed: () => showMenuBottomSheet(
                context: context,
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    ListTile(
                      leading: Icon(
                        Icons.report_outlined,
                        color: Theme.of(context).colorScheme.error,
                      ),
                      title: Text(
                        Strings.report,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.error,
                        ),
                      ),
                      onTap: () {
                        context.pushNamed(RouteName.report,
                            extra: ReportType.comment,
                            pathParameters: {FirebaseFieldName.id: comment.id});
                      },
                    ),
                    if (currentUid != null && currentUid == uid)
                      ListTile(
                        leading: const Icon(Icons.delete_outline),
                        title: const Text(Strings.delete),
                        onTap: () {
                          const DeleteDialog(objectName: Strings.comment)
                              .show(context)
                              .then((res) {
                            if (res == true) {
                              ref
                                  .read(commentProvider.notifier)
                                  .deleteComment(commentId: comment.id);
                            }
                          });
                        },
                      )
                  ],
                ),
              ),
              icon: const Icon(CupertinoIcons.ellipsis_vertical),
            )
          : null,
    );
  }
}
