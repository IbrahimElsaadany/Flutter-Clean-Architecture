import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/strings/keys.dart';
import '../models/post_model.dart';

abstract class PostsLocalDatasource{
  Future<List<PostModel>> getCachedPosts();
  Future<Unit> cachePosts(final List<PostModel> posts);
}

class PostsLocalDatasourceImpl implements PostsLocalDatasource{
  final SharedPreferences _prefs;

  PostsLocalDatasourceImpl(this._prefs);

  @override
  Future<List<PostModel>> getCachedPosts(){
    final String? jsonString = _prefs.getString(postsKey);
    if(jsonString != null){
      final List decodedJsonData = json.decode(jsonString);
      final List<PostModel> posts = decodedJsonData.map<PostModel>((final p) => PostModel.fromJson(p)).toList();
      return Future.value(posts);
    }
    throw EmptyCacheException();
  }

  @override
  Future<Unit> cachePosts(final List<PostModel> posts){
    final List<Map<String, dynamic>> postsJsons = posts.map<Map<String, dynamic>>((final PostModel p) => p.toJson()).toList();
    _prefs.setString(postsKey, json.encode(postsJsons));
    return Future.value(unit);
  }
}