import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pixgraphy/route/route_const.dart';
import 'package:pixgraphy/state/auth/provider/user_id_provider.dart';
import 'package:pixgraphy/state/constant/firebase_const.dart';
import 'package:pixgraphy/state/date/extension/date_format.dart';
import 'package:pixgraphy/view/components/constants/strings.dart';
import 'package:pixgraphy/view/components/model_bottom_sheet/menu_bottom_sheet.dart';
import 'package:pixgraphy/view/components/post/like_button.dart';
import 'package:pixgraphy/view/components/post/network_image_view.dart';
import 'package:pixgraphy/view/components/post/post_menu_list.dart';
import 'package:pixgraphy/view/components/profile/profile_circle_avathar.dart';
import 'package:pixgraphy/view/components/profile/profile_name.dart';
import 'package:pixgraphy/view/components/text/subtitle.dart';
import 'package:pixgraphy/view/components/text/title.dart';
import '../../../state/post/model/post.dart';
import '../../../state/post/notifier/post_notifier.dart';
import '../comment/comment_card.dart';
import '../snakbar/snakbar_model.dart';

class PostDetailView extends ConsumerWidget {
  final Post post;
  const PostDetailView({
    super.key,
    required this.post,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userId = ref.watch(userIdProvider);
    ref.listen(postProvider, (_, state) {
      state.maybeWhen(
          failure: (failure) => AppSnackbar(
                message: Strings.somethingwentwrong,
                context: context,
              ),
          deleted: () {
            context.pop();
          },
          orElse: () => null);
    });
    final isLoading = ref
        .watch(postProvider)
        .maybeMap(loading: (_) => true, orElse: () => false);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const BackButton(),
              if (isLoading) const LinearProgressIndicator(),
              Card(
                margin: const EdgeInsets.all(8),
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ProfileCircleAvatar(
                            uid: post.uid,
                            onTap: () => context.pushNamed(
                              RouteName.profile,
                              params: {FirebaseFieldName.uid: post.uid},
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ProfileName(
                                  uid: post.uid,
                                  onTap: () => context.pushNamed(
                                    RouteName.profile,
                                    params: {FirebaseFieldName.uid: post.uid},
                                  ),
                                ),
                                SubTitleWidget(
                                  text: post.createdAt.format(),
                                ),
                              ],
                            ),
                          ),
                          const Spacer(),
                          IconButton(
                            onPressed: () => showMenuBottomSheet(
                              context: context,
                              child: PostMenuList(post: post),
                            ),
                            icon: const Icon(CupertinoIcons.ellipsis_vertical),
                          )
                        ],
                      ),
                      if (post.title != null) TitleWidget(text: post.title!),
                      if (post.description != null)
                        SubTitleWidget(text: post.description!),
                      Card(
                        clipBehavior: Clip.antiAlias,
                        child: Hero(
                          tag: post.postId,
                          child: GestureDetector(
                            onTap: () => context.pushNamed(
                              RouteName.postFull,
                              extra: post.url,
                            ),
                            child: AspectRatio(
                              aspectRatio: post.aspectRatio,
                              child: NetworkImageView(
                                post.thumbnailUrl,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          LikeButton(postId: post.postId),
                          if (post.shotOn != null)
                            SubTitleWidget(text: "📷 ${post.shotOn!} ")
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              CommentCard(post: post, userId: userId)
            ],
          ),
        ),
      ),
    );
  }
}
