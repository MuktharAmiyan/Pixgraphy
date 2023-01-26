import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pixgraphy/state/image_upload/notifier/image_picker_notifier.dart';
import 'package:pixgraphy/state/user_info/model/user_info_model.dart';
import 'package:pixgraphy/state/user_info/notifier/user_info_notifier.dart';
import 'package:pixgraphy/view/components/constants/strings.dart';
import 'package:pixgraphy/view/components/liner_progress/appbar_bottom_loading.dart';
import 'package:pixgraphy/view/components/profile/profile_circle_avathar.dart';
import 'package:pixgraphy/view/components/snakbar/error_snakbar.dart';
import 'package:pixgraphy/view/components/snakbar/snakbar_model.dart';

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
  final _nameControler = TextEditingController();
  final _userNameControler = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  File? image;
  @override
  void initState() {
    super.initState();
    _nameControler.text = widget.user.name;
    _userNameControler.text = widget.user.username;
  }

  @override
  void dispose() {
    super.dispose();
    _nameControler.dispose();
    _userNameControler.dispose();
  }

  String? _validateUserName(String? input) {
    if (input!.isNotEmpty) {
      return null;
    }
    return Strings.cantbeEmpty;
  }

  Future<void> _save() async {
    if (_formKey.currentState!.validate()) {
      final userName = _userNameControler.text.trim() == widget.user.username
          ? null
          : _userNameControler.text.trim().toLowerCase().replaceAll(' ', '');
      final name = _nameControler.text.trim() == widget.user.name
          ? null
          : _nameControler.text.trim();
      final photo = ref.watch(imagePickerProvider).maybeMap(
          success: (image) => image.imageWithThumbnailAndAspectRatio.tumbnail,
          orElse: () => null);
      if (userName == null && name == null && photo == null) {
        context.pop();
      } else {
        ref
            .read(userInfoProvider.notifier)
            .editProfile(userName: userName, name: name, photo: photo);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(userInfoProvider, (_, state) {
      state.maybeWhen(
        success: () {
          ref.refresh(imagePickerProvider);
          context.pop();
        },
        faliure: () {
          ErrorSnackbar(errorText: Strings.somethingwentwrong, context: context)
              .show;
        },
        orElse: () {},
      );
    });
    final isLoading = ref.watch(userInfoProvider).maybeWhen(
          orElse: () => false,
          loading: () => true,
        );

    return WillPopScope(
      onWillPop: () async {
        // ignore: unused_result
        ref.refresh(imagePickerProvider);
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text(Strings.editprofile),
          bottom: isLoading ? const AppbarBottomLoading() : null,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  ref.watch(imagePickerProvider).maybeWhen(
                      orElse: () => ProfileCircleAvatar(
                            uid: widget.user.uid,
                            radius: 60,
                          ),
                      success: (image) => CircleAvatar(
                            radius: 60,
                            backgroundImage: MemoryImage(image.tumbnail),
                          )),
                  TextButton(
                    onPressed: ref.read(imagePickerProvider.notifier).pickImage,
                    child: const Text(
                      Strings.changePhoto,
                    ),
                  ),
                  TextFormField(
                      controller: _nameControler,
                      decoration: const InputDecoration(
                        labelText: Strings.name,
                      ),
                      validator: _validateUserName),
                  const SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    controller: _userNameControler,
                    decoration: const InputDecoration(
                      labelText: Strings.username,
                    ),
                    validator: _validateUserName,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  FilledButton(
                    onPressed: _save,
                    child: const Text(Strings.save),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
