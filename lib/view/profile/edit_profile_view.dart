import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pixgraphy/state/user_info/model/user_info_model.dart';
import 'package:pixgraphy/view/components/constants/strings.dart';
import 'package:pixgraphy/view/components/profile/profile_circle_avathar.dart';

class EditProfileview extends ConsumerStatefulWidget {
  final UserInfoModel user;
  const EditProfileview({
    super.key,
    required this.user,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _EditProfileviewState();
}

class _EditProfileviewState extends ConsumerState<EditProfileview> {
  TextEditingController nameControler = TextEditingController();
  TextEditingController userNameControler = TextEditingController();
  @override
  void initState() {
    super.initState();
    nameControler.text = widget.user.name;
    userNameControler.text = widget.user.username;
  }

  @override
  void dispose() {
    super.dispose();
    nameControler.dispose();
    userNameControler.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(Strings.editprofile),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              ProfileCircleAvatar(
                uid: widget.user.uid,
                radius: 60,
              ),
              TextButton(
                  onPressed: () {}, child: const Text(Strings.changePhoto)),
              TextField(
                controller: nameControler,
                decoration: const InputDecoration(
                  labelText: Strings.name,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              TextField(
                controller: userNameControler,
                decoration: const InputDecoration(
                  labelText: Strings.username,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
