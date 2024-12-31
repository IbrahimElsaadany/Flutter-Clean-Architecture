import 'package:dio/dio.dart';

import '../../../../core/errors/exceptions.dart';
import '../models/user_model.dart';

abstract class UsersRemoteDatasource{
  Future<UserModel> getUser(final int id);
}

class UsersRemoteDatasourceImpl implements UsersRemoteDatasource{
  final Dio _dio;

  UsersRemoteDatasourceImpl(this._dio);

  @override
  Future<UserModel> getUser(final int id) async{
    final Response response = await _dio.get("users/$id");
    if(response.statusCode == 200){
      final UserModel user = UserModel.fromJson(response.data);
      return user;
    }
    throw ServerException();
  }
}