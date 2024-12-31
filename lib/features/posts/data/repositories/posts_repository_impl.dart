import 'package:clean_architecture_posts_app/core/errors/exceptions.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/post_entity.dart';
import '../../domain/repository/posts_repository.dart';
import '../datasources/posts_local_datasource.dart';
import '../datasources/posts_remote_datasource.dart';
import '../models/post_model.dart';

class PostsRepositoryImpl implements PostsRepository{
  final PostsLocalDatasource _localDatasource;
  final PostsRemoteDatasource _remoteDatasource;
  final NetworkInfo _networkInfo;

  PostsRepositoryImpl({
    required final PostsLocalDatasource localDatasource,
    required final PostsRemoteDatasource remoteDatasource,
    required final NetworkInfo networkInfo
  }): _localDatasource = localDatasource,
    _remoteDatasource = remoteDatasource,
    _networkInfo = networkInfo;

  @override
  Future<Either<Failure, List<PostModel>>> getAllPosts() async{
    if(await _networkInfo.isDeviceConnected){
      try{
        final List<PostModel> posts = await _remoteDatasource.getAllPosts();
        _localDatasource.cachePosts(posts);
        return Right(posts);
      }on ServerException{
        return Left(ServerFailure());
      }
    }else{
      try{
        final List<PostModel> posts = await _localDatasource.getCachedPosts();
        return Right(posts);
      }on EmptyCacheException{
        return Left(EmptyCacheFailure());
      }
    }
    
  }

  @override
  Future<Either<Failure, Unit>> addPost(final PostEntity post) {
    final PostModel postModel = PostModel(title: post.title, body: post.body, userId: post.userId);
    return _addOrUpdateOrDeletePost(() => _remoteDatasource.addPost(postModel));
  }

  @override
  Future<Either<Failure, Unit>> updatePost(final PostEntity post) {
    final PostModel postModel = PostModel(id: post.id, title: post.title, body: post.body, userId: post.userId);
    return _addOrUpdateOrDeletePost(() => _remoteDatasource.updatePost(postModel));
  }

  @override
  Future<Either<Failure, Unit>> deletePost(final int id)
  => _addOrUpdateOrDeletePost(() => _remoteDatasource.deletePost(id));

  Future<Either<Failure, Unit>> _addOrUpdateOrDeletePost(final Future<Unit> Function() func) async{
    if(await _networkInfo.isDeviceConnected){
      try{
        return Right(await func());
      }on ServerException{
        return Left(ServerFailure());
      }
    }else return Left(OfflineFailure());
  }
}