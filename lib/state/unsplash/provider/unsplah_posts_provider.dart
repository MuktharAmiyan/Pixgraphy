import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pixgraphy/api_keys.dart';
import 'package:pixgraphy/state/unsplash/model/unsplash_post.dart';
import 'package:http/http.dart' as http;

final unsplashPostsProvider =
    FutureProvider.autoDispose<Iterable<UnPost>>((ref) async {
  final completer = Completer<Iterable<UnPost>>();

  final response = await http.get(Uri.parse(
      'https://api.unsplash.com/photos/?client_id=$unsplahKey&per_page=30'));
  final responsePage2 = await http.get(Uri.parse(
      'https://api.unsplash.com/photos/?client_id=$unsplahKey&page=2&per_page=30'));
  if (response.statusCode == 200 && responsePage2.statusCode == 200) {
    final posts = jsonDecode(response.body) as List;
    posts.addAll(jsonDecode(responsePage2.body) as List);
    final unPosts = posts.map((e) => UnPost.fromJson(e));

    completer.complete(unPosts);
  }

  return completer.future;
});
