import '../../../domain/entities/post_entity.dart';

abstract class PostsStates{}

class PostsInitialState extends PostsStates{}

class PostsLoadingState extends PostsStates{}

class PostsLoadingSuccessState extends PostsStates{
  final List<PostEntity> posts;

  PostsLoadingSuccessState(this.posts);
}

class PostsLoadingFailedState extends PostsStates{
  final String message;
  
  PostsLoadingFailedState(this.message);
}