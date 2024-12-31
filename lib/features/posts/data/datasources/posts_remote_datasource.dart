import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../core/errors/exceptions.dart';
import '../models/post_model.dart';

abstract class PostsRemoteDatasource{
  Future<List<PostModel>> getAllPosts();
  Future<Unit> addPost(final PostModel post);
  Future<Unit> updatePost(final PostModel post);
  Future<Unit> deletePost(final int id);
}

class PostsRemoteDatasourceImpl implements PostsRemoteDatasource{
  final Dio _dio;

  PostsRemoteDatasourceImpl(this._dio);

  @override
  Future<List<PostModel>> getAllPosts() async{
    final Response response = await _dio.get("posts");
    if(response.statusCode == 200){
      final List<PostModel> posts = response.data.map<PostModel>((final e) => PostModel.fromJson(e)).toList();
      return posts;
    }
    throw ServerException();
  }
  
  @override
  Future<Unit> addPost(final PostModel post) async{
    final Response response = await _dio.post("posts", data:  post.toJson());
    if(response.statusCode == 201) return Future.value(unit);
    throw ServerException();
  }

  @override
  Future<Unit> updatePost(final PostModel post) async{
    final Response response = await _dio.put("posts/${post.id}");
    if(response.statusCode == 200) return Future.value(unit);
    throw ServerException();
  }

  @override
  Future<Unit> deletePost(final int id) async{
    final Response response = await _dio.delete("posts/$id");
    if(response.statusCode == 200) return Future.value(unit);
    throw ServerException();
  }
}