import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pixgraphy/route/route_const.dart';
import 'package:pixgraphy/state/post/model/post.dart';
import 'package:pixgraphy/state/report/model/report_type.dart';
import 'package:pixgraphy/state/unsplash/model/unsplash_post.dart';
import 'package:pixgraphy/state/user_info/model/user_info_model.dart';
import 'package:pixgraphy/view/add_post/add_post_view.dart';
import 'package:pixgraphy/view/auth/landing_view.dart';
import 'package:pixgraphy/view/auth/sign_in_view.dart';
import 'package:pixgraphy/view/auth/sign_up_view.dart';
import 'package:pixgraphy/view/components/post/post_detail_view.dart';
import 'package:pixgraphy/view/components/unsplash/unsplash_post_detail_view.dart';
import 'package:pixgraphy/view/main/main_view.dart';
import 'package:pixgraphy/view/profile/edit_profile_view.dart';
import 'package:pixgraphy/view/profile/profile_view.dart';
import 'package:pixgraphy/view/report/report_view.dart';
import 'package:pixgraphy/view/search/search_view.dart';
import 'package:pixgraphy/view/settings/settings_theme_view.dart';
import 'package:pixgraphy/view/settings/settings_view.dart';
import '../state/auth/notifier/auth_state_notifier.dart';
import '../state/constant/firebase_const.dart';
import '../view/explore/unsplash_explore_view.dart';

final goRouteProvider = Provider<GoRouter>((ref) {
  final route = RouterNotifier(ref);
  return GoRouter(
    initialLocation: RoutePath.main,
    refreshListenable: route,
    routes: route.routes,
    redirect: route._redirectLogic,
    debugLogDiagnostics: true,
  );
});

class RouterNotifier extends ChangeNotifier {
  final Ref ref;
  RouterNotifier(this.ref) {
    ref.listen(
      authStateProvider,
      (previous, next) => notifyListeners(),
    );
  }

  String? _redirectLogic(BuildContext context, GoRouterState state) {
    final authState = ref.read(authStateProvider);
    final areWeLanding = state.location == RoutePath.landing;
    final areWeSignIn = state.location == RoutePath.signIn;
    final areWeSignUp = state.location == RoutePath.signUp;

    return authState.maybeMap(
      unKnown: (_) => areWeLanding ? null : RoutePath.landing,
      loading: (_) => null,
      signIn: (_) => areWeSignIn ? null : RoutePath.signIn,
      signUp: (_) => areWeSignUp ? null : RoutePath.signUp,
      error: (_) => null,
      orElse: () {
        if (state.location == RoutePath.landing ||
            state.location == RoutePath.signIn ||
            state.location == RoutePath.signUp) {
          return RoutePath.main;
        }
        return null;
      },
    );
  }

  List<RouteBase> get routes => [
        GoRoute(
          path: RoutePath.landing,
          builder: (context, state) => const LandingView(),
        ),
        GoRoute(
          name: RouteName.main,
          path: RoutePath.main,
          builder: (context, state) => const MainView(),
        ),
        GoRoute(
          name: RouteName.search,
          path: RoutePath.search,
          builder: (context, state) => const SearchView(),
        ),
        GoRoute(
          name: RouteName.addPost,
          path: RoutePath.addPost,
          builder: (context, state) => const AddPost(),
        ),
        GoRoute(
          name: RouteName.unsplashSearch,
          path: RoutePath.unsplashSearch,
          builder: (context, state) => const UnsplashExploreView(),
        ),
        GoRoute(
          path: RoutePath.signIn,
          builder: (context, state) => const SignInView(),
        ),
        GoRoute(
          path: RoutePath.signUp,
          builder: (context, state) => const SignUpView(),
        ),
        GoRoute(
            name: RouteName.profile,
            path: RoutePath.profile,
            builder: (context, state) => ProfileView(
                  uid: state.params[FirebaseFieldName.uid]!,
                ),
            routes: [
              GoRoute(
                name: RouteName.editProfile,
                path: RoutePath.editProfile,
                builder: (context, state) => EditProfileview(
                  user: state.extra as UserInfoModel,
                ),
              )
            ]),
        GoRoute(
            name: RouteName.settings,
            path: RoutePath.settings,
            builder: (context, state) => const SettingsView(),
            routes: [
              GoRoute(
                name: RouteName.theme,
                path: RoutePath.theme,
                builder: (context, state) => const SettingsThemeView(),
              )
            ]),
        GoRoute(
          name: RouteName.postDetail,
          path: RoutePath.postDetail,
          builder: (context, state) => PostDetailView(
            post: state.extra! as Post,
          ),
        ),
        GoRoute(
          name: RouteName.unPostDetail,
          path: RoutePath.unPostDetail,
          builder: (context, state) => UnsplashPostDetailView(
            post: state.extra! as UnPost,
          ),
        ),
        GoRoute(
          name: RouteName.report,
          path: RoutePath.report,
          builder: (context, state) => ReportView(
            reportType: state.extra as ReportType,
            id: state.params[FirebaseFieldName.id]!,
          ),
        )
      ];
}
