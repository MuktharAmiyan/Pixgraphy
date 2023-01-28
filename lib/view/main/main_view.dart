import 'dart:developer';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pixgraphy/state/auth/notifier/auth_state_notifier.dart';
import 'package:pixgraphy/state/connectivity/conectivity_provider.dart';
import 'package:pixgraphy/state/post/provider/feed_provider.dart';
import 'package:pixgraphy/state/user_info/provider/user_info_provider.dart';
import 'package:pixgraphy/view/components/app_bar/main_app_bar.dart';
import 'package:pixgraphy/view/components/constants/strings.dart';
import 'package:pixgraphy/view/components/post/masonary_post_grid_view.dart';
import 'package:pixgraphy/view/components/snakbar/snakbar_model.dart';
import '../../route/route_const.dart';
import '../../state/auth/provider/user_id_provider.dart';
import '../components/drawer/profile_drawer.dart';

class MainView extends ConsumerStatefulWidget {
  const MainView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MainViewState();
}

class _MainViewState extends ConsumerState<MainView> {
  final _scrollController = ScrollController();
  bool _showBottom = true;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        _showBottom = false;
        setState(() {});
      }
      if (_scrollController.position.userScrollDirection ==
          ScrollDirection.forward) {
        _showBottom = true;
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final uid = ref.watch(userIdProvider);
    //FOR THE CHECKING SUSPENDED USER
    ref.listen(userInfoStreamProvider(uid), (_, next) {
      next.maybeWhen(
        data: (user) {
          if (user.isDisabled == true) {
            AppSnackbar(message: Strings.accountDisabled, context: context)
                .show;
            Future.delayed(const Duration(seconds: 4), () {
              ref.read(authStateProvider.notifier).signOut();
            });
          }
        },
        orElse: () => null,
      );
    });

    //CONNECTION CHECK
    ref.listen(connectivityProvider, (_, result) {
      result.whenOrNull(
        data: (connectivity) {
          log(connectivity.toString());
          if (connectivity == ConnectivityResult.none) {
            AppSnackbar(
              message: Strings.noInternetFound,
              context: context,
              action: SnackBarAction(
                label: Strings.retry,
                onPressed: () => ref.refresh(connectivityProvider),
              ),
            ).show;
          }
        },
      );
    });

    return Scaffold(
      appBar: MainAppBar(_showBottom),
      drawer: ProfileDrawer(
        uid: uid,
      ),
      body: ref.watch(feedProvider).when(
            data: (posts) => MasonaryPostGridView(
              scrollController: _scrollController,
              posts: posts,
            ),
            error: (_, __) => const Center(
              child: Icon(Icons.error_outline),
            ),
            loading: () => const Center(
              child: CircularProgressIndicator(),
            ),
          ),
      bottomNavigationBar: AnimatedContainer(
        duration: const Duration(milliseconds: 800),
        curve: Curves.ease,
        height: _showBottom ? 60 : 0,
        child: BottomAppBar(
          clipBehavior: Clip.antiAlias,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              IconButton(
                tooltip: Strings.unsplashExplore,
                onPressed: () => context.pushNamed(RouteName.unsplashSearch),
                icon: const Icon(Icons.travel_explore),
              ),
              IconButton(
                tooltip: Strings.notification,
                onPressed: () => context.push(RoutePath.notification),
                icon: const Icon(Icons.notifications_outlined),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: _showBottom
          ? FloatingActionButton.small(
              tooltip: Strings.addPost,
              onPressed: () => context.pushNamed(RouteName.addPost),
              child: const Icon(Icons.add),
            )
          : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.endContained,
    );
  }
}
