import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pixgraphy/route/route_const.dart';
import 'package:pixgraphy/state/constant/firebase_const.dart';
import 'package:pixgraphy/state/post/model/post.dart';
import 'package:pixgraphy/state/report/model/report_type.dart';
import 'package:pixgraphy/view/components/dialogs/alert_dialog.dart';

import '../../../state/auth/provider/user_id_provider.dart';
import '../../../state/post/notifier/post_notifier.dart';
import '../constants/strings.dart';
import '../dialogs/delete_dialog.dart';

class PostMenuList extends ConsumerWidget {
  final Post post;
  const PostMenuList({super.key, required this.post});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userId = ref.watch(userIdProvider);

    return ListView(
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
                extra: ReportType.post,
                pathParameters: {FirebaseFieldName.id: post.postId});
          },
        ),
        if (userId != null && userId == post.uid)
          ListTile(
            leading: const Icon(Icons.delete_outline),
            title: const Text(Strings.delete),
            onTap: () {
              const DeleteDialog(objectName: Strings.post)
                  .show(context)
                  .then((res) {
                if (res == true) {
                  ref.read(postProvider.notifier).deletePost(post: post);
                  context.pop();
                }
              });
            },
          ),
      ],
    );
  }
}
