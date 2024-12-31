import 'package:dartz/dartz.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/repositories/users_repository.dart';
import '../datasources/users_local_datasource.dart';
import '../datasources/users_remote_datasource.dart';
import '../models/user_model.dart';

class UsersRepositoryImpl implements UsersRepository{
  final NetworkInfo _networkInfo;
  final UsersRemoteDatasource _remoteDatasource;
  final UsersLocalDatasource _localDatasource;

  UsersRepositoryImpl({
    required final NetworkInfo networkInfo,
    required final UsersRemoteDatasource remoteDatasource,
    required final UsersLocalDatasource localDatasource,
  }): _networkInfo = networkInfo,
    _remoteDatasource = remoteDatasource,
    _localDatasource = localDatasource;

  @override
  Future<Either<Failure, UserModel>> getUser(final int id) async{
    if(await _networkInfo.isDeviceConnected){
      try{
        final UserModel user = await _remoteDatasource.getUser(id);
        _localDatasource.cacheUser(user);
        return Right(user);
      }on ServerException{
        return Left(ServerFailure());
      }
    }else{
      try{
        final UserModel user = await _localDatasource.getCachedUser(id);
        return Right(user);
      }on EmptyCacheException{
        return Left(EmptyCacheFailure());
      }
    }
  }
}