import 'package:flutter/material.dart';
import 'package:pixgraphy/state/image_upload/model/image_with_thumbnail_and_aspect_ratio.dart';
import 'package:pixgraphy/view/components/constants/strings.dart';

class CreatePostView extends StatelessWidget {
  final ImageWithThumbnailAndAspectRatio allImages;
  final TextEditingController titleController;
  final TextEditingController descriptionController;
  final TextEditingController shotOnController;
  const CreatePostView({
    super.key,
    required this.allImages,
    required this.titleController,
    required this.shotOnController,
    required this.descriptionController,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Form(
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.memory(
                allImages.tumbnail,
                fit: BoxFit.fitHeight,
                height: 250,
              ),
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: titleController,
              decoration: const InputDecoration(
                hintText: Strings.titleForYourPic,
                counterText: '',
              ),
              maxLength: 50,
              textInputAction: TextInputAction.next,
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: shotOnController,
              decoration: const InputDecoration(
                hintText: Strings.shotOn,
                prefixIcon: Icon(Icons.camera_outlined),
                counterText: '',
              ),
              maxLength: 50,
              textInputAction: TextInputAction.next,
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: descriptionController,
              decoration: const InputDecoration(
                hintText: Strings.description,
              ),
              maxLength: 155,
              maxLines: 3,
              textInputAction: TextInputAction.done,
            ),
          ],
        ),
      ),
    );
  }
}
