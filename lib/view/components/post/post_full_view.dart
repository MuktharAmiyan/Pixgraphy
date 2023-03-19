import 'package:flutter/material.dart';
import 'package:pixgraphy/view/components/post/network_image_view.dart';

class PostFullView extends StatelessWidget {
  final String url;
  const PostFullView({required this.url, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: InteractiveViewer(
        maxScale: 10,
        child: Center(
          child: NetworkImageView(
            url,
          ),
        ),
      ),
    );
  }
}
