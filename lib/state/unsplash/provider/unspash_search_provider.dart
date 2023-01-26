import 'dart:async';
import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pixgraphy/api_keys.dart';
import 'package:pixgraphy/state/unsplash/model/unsplash_post.dart';
import 'package:http/http.dart' as http;

final unsplashSearchPostsProvider =
    FutureProvider.family<Iterable<UnPost>, String>((ref, String query) async {
  final completer = Completer<Iterable<UnPost>>();

  final response = await http.get(Uri.parse(
      'https://api.unsplash.com/search/photos/?client_id=$unsplahKey&per_page=30&query=$query'));
  final response2 = await http.get(Uri.parse(
      'https://api.unsplash.com/search/photos/?client_id=$unsplahKey&per_page=30&query=$query&page=2'));
  if (response.statusCode == 200 && response2.statusCode == 200) {
    final posts = jsonDecode(response.body)['results'] as List;
    posts.addAll(jsonDecode(response2.body)['results'] as List);
    final unPosts = posts.map((e) => UnPost.fromJson(e));
    completer.complete(unPosts);
  }

  return completer.future;
});
