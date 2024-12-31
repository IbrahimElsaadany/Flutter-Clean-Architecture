import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/post_entity.dart';
import '../repository/posts_repository.dart';

class GetAllPostsUsecase{
  final PostsRepository _repository;

  GetAllPostsUsecase(this._repository);

  Future<Either<Failure, List<PostEntity>>> call()
  => _repository.getAllPosts();
}