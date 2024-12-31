import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/post_entity.dart';
import '../repository/posts_repository.dart';

class UpdatePostUsecase{
  final PostsRepository _repository;

  UpdatePostUsecase(this._repository);

  Future<Either<Failure, Unit>> call(final PostEntity post)
  => _repository.updatePost(post);
}