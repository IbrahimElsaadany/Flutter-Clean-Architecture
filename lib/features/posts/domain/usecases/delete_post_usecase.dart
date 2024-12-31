import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../repository/posts_repository.dart';

class DeletePostUsecase{
  final PostsRepository _repository;

  DeletePostUsecase(this._repository);

  Future<Either<Failure, Unit>> call(final int id)
  => _repository.deletePost(id);
}