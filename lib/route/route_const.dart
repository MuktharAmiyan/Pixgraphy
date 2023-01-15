import 'package:flutter/foundation.dart';
import 'package:pixgraphy/state/constant/firebase_const.dart';

@immutable
class RouteName {
  const RouteName._();
  static const profile = 'profile';
  static const settings = 'settings';
  static const theme = 'theme';
  static const main = 'main';
  static const search = 'search';
  static const addPost = 'addPost';
  static const unsplashSearch = 'unsplashSearch';
  static const postDetail = 'post-detail';
  static const editProfile = 'edit-profile';
  static const report = 'report';
}

@immutable
class RoutePath {
  const RoutePath._();

  static const landing = '/landing';
  static const signIn = '/signin';
  static const signUp = '/signup';
  static const profile = '/user/:${FirebaseFieldName.uid}';
  static const settings = '/settings';
  static const main = '/';
  static const theme = 'theme';
  static const search = '/search';
  static const addPost = '/addPost';
  static const unsplashSearch = '/unsplash-search';
  static const postDetail = '/post-detail';
  static const editProfile = 'edit-profile';
  static const report = '/report/:id';
}
