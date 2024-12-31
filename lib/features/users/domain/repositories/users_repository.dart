import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/user_entity.dart';

abstract class UsersRepository{
  Future<Either<Failure, UserEntity>> getUser(final int id);
}