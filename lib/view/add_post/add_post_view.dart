import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pixgraphy/view/add_post/create_post_view.dart';
import 'package:pixgraphy/view/components/constants/strings.dart';
import 'package:pixgraphy/view/components/liner_progress/appbar_bottom_loading.dart';
import 'package:pixgraphy/view/components/snakbar/snakbar_model.dart';
import '../../state/image_upload/notifier/image_picker_notifier.dart';
import '../../state/image_upload/notifier/post_upload_notifier.dart';

class AddPost extends ConsumerStatefulWidget {
  const AddPost({super.key});
  @override
  ConsumerState<AddPost> createState() => _AddPostState();
}

class _AddPostState extends ConsumerState<AddPost> {
  final descriptionController = TextEditingController();
  final shotOnController = TextEditingController();
  final titleController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    descriptionController.dispose();
    shotOnController.dispose();
    titleController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(imagePickerProvider, (_, state) {
      state.maybeMap(
        initial: (_) {
          titleController.clear();
          descriptionController.clear();
          shotOnController.clear();
        },
        thumbnailIsNull: (_) => AppSnackbar(
          message: Strings.errorThumnailmsg,
          context: context,
        ).show,
        orElse: () => null,
      );
    });

    ref.listen(postUploadProvider, (_, state) {
      state.maybeWhen(
          success: () => ref.refresh(imagePickerProvider),
          failed: () =>
              AppSnackbar(message: Strings.postUploadErrorMsg, context: context)
                  .show,
          orElse: () => null);
    });
    final isLoading = ref
        .watch(postUploadProvider)
        .maybeWhen(loading: () => true, orElse: () => false);

    return WillPopScope(
      onWillPop: () async {
        return isLoading ? false : true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text(Strings.addPost),
          bottom: isLoading ? const AppbarBottomLoading() : null,
        ),
        body: ref.watch(imagePickerProvider).when(
              initial: () => Center(
                child: FloatingActionButton.extended(
                  onPressed: ref.read(imagePickerProvider.notifier).pickImage,
                  label: const Text(Strings.pickImage),
                  icon: const Icon(Icons.add),
                ),
              ),
              loading: () => const Center(child: CircularProgressIndicator()),
              thumbnailIsNull: () => Center(
                child: TextButton(
                  onPressed: ref.read(imagePickerProvider.notifier).pickImage,
                  child: const Text(Strings.pickImage),
                ),
              ),
              success: (allImages) => SingleChildScrollView(
                child: Column(
                  children: [
                    if (isLoading) const LinearProgressIndicator(),
                    CreatePostView(
                      allImages: allImages,
                      titleController: titleController,
                      shotOnController: shotOnController,
                      descriptionController: descriptionController,
                    ),
                  ],
                ),
              ),
            ),
        floatingActionButton: ref.watch(imagePickerProvider).maybeWhen(
              orElse: () => null,
              success: (allImage) => Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  FloatingActionButton.extended(
                    onPressed: () {
                      if (!isLoading) {
                        FocusScope.of(context).unfocus();
                        ref.read(postUploadProvider.notifier).upload(
                              allImage: allImage,
                              title: titleController.text.trim(),
                              shotOn: shotOnController.text.trim(),
                              description: descriptionController.text.trim(),
                            );
                      }
                    },
                    label: const Text(Strings.upload),
                    icon: const Icon(Icons.upload_outlined),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  FloatingActionButton(
                    onPressed: () {
                      if (!isLoading) {
                        ref.read(imagePickerProvider.notifier).cancel();
                      }
                    },
                    child: const Icon(Icons.cancel),
                  )
                ],
              ),
            ),
      ),
    );
  }
}
