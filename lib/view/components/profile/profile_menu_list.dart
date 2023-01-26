import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../route/route_const.dart';
import '../../../state/constant/firebase_const.dart';
import '../../../state/report/model/report_type.dart';
import '../constants/strings.dart';

class ProfileMenuList extends StatelessWidget {
  final String uid;
  const ProfileMenuList({super.key, required this.uid});

  @override
  Widget build(BuildContext context) {
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
                extra: ReportType.user, params: {FirebaseFieldName.id: uid});
          },
        ),
      ],
    );
  }
}
