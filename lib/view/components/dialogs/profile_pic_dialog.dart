import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pixgraphy/state/user_info/provider/user_info_provider.dart';
import 'package:pixgraphy/view/components/constants/asset_path.dart';
import 'package:pixgraphy/view/components/constants/strings.dart';

Future<void> showProfile(
  BuildContext context,
  String? uid,
) =>
    showDialog(
      context: context,
      builder: (_) => Consumer(
        builder: (___, ref, _) => Dialog(
          child: ref.read(userInfoProvider(uid)).when(
                data: (user) {
                  if (user.photoUrl == null) {
                    return Image.asset(
                      AssetPath.defaultProPic,
                      fit: BoxFit.contain,
                    );
                  }
                  return Image.network(
                    user.photoUrl!,
                    fit: BoxFit.contain,
                  );
                },
                error: (e, __) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    e.toString(),
                    textAlign: TextAlign.center,
                  ),
                ),
                loading: () => const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    Strings.loading,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
        ),
      ),
    );
