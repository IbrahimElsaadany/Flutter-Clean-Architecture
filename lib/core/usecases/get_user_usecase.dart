import 'package:dartz/dartz.dart';

import '../../features/users/domain/entities/user_entity.dart';
import '../../features/users/domain/repositories/users_repository.dart';
import '../errors/failures.dart';

class GetUserUsecase{
  final UsersRepository _repository;

  GetUserUsecase(this._repository);

  Future<Either<Failure, UserEntity>> call(final int id)
  => _repository.getUser(id);
}