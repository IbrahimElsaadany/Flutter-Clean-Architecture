import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/errors/exceptions.dart';
import '../models/user_model.dart';

abstract class UsersLocalDatasource{
  Future<UserModel> getCachedUser(final int id);
  Future<Unit> cacheUser(final UserModel user);
}

class UsersLocalDatasourceImpl implements UsersLocalDatasource{
  final SharedPreferences _prefs;

  UsersLocalDatasourceImpl(this._prefs);

  @override
  Future<UserModel> getCachedUser(final int id){
    final String? jsonString = _prefs.getString("user$id");
    if(jsonString != null){
      final Map<String, dynamic> decodedJsonData = json.decode(jsonString);
      final UserModel user = UserModel.fromJson(decodedJsonData);
      return Future.value(user);
    }
    throw EmptyCacheException();
  }

  @override
  Future<Unit> cacheUser(final UserModel user){
    final Map<String, dynamic> userJson = user.toJson();
    _prefs.setString("user${user.id}", json.encode(userJson));
    return Future.value(unit);
  }
}