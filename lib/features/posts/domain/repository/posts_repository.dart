import "package:dartz/dartz.dart";

import "../../../../core/errors/failures.dart";
import "../entities/post_entity.dart";

abstract class PostsRepository{
  Future<Either<Failure, List<PostEntity>>> getAllPosts();
  Future<Either<Failure, Unit>> addPost(final PostEntity post);
  Future<Either<Failure, Unit>> updatePost(final PostEntity post);
  Future<Either<Failure, Unit>> deletePost(final int id);
}