import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/network/network_info.dart';
import 'core/strings/urls.dart';
import 'core/usecases/get_user_usecase.dart';
import 'features/posts/data/datasources/posts_local_datasource.dart';
import 'features/posts/data/datasources/posts_remote_datasource.dart';
import 'features/posts/data/repositories/posts_repository_impl.dart';
import 'features/posts/domain/repository/posts_repository.dart';
import 'features/posts/domain/usecases/add_post_usecase.dart';
import 'features/posts/domain/usecases/delete_post_usecase.dart';
import 'features/posts/domain/usecases/get_all_posts_usecase.dart';
import 'features/posts/domain/usecases/update_post_usecase.dart';
import 'features/posts/presentation/bloc/posts/posts_bloc.dart';
import 'features/posts/presentation/bloc/single_post/single_post_bloc.dart';
import 'features/users/data/datasources/users_local_datasource.dart';
import 'features/users/data/datasources/users_remote_datasource.dart';
import 'features/users/data/repositories/users_repository_impl.dart';
import 'features/users/domain/repositories/users_repository.dart';

final GetIt getIt = GetIt.instance;

Future<void> setupDependencyInjection() async{
  
  // Blocs
  getIt.registerLazySingleton<PostsBloc>(() => PostsBloc(getIt<GetAllPostsUsecase>()));
  getIt.registerLazySingleton<SinglePostBloc>(() => SinglePostBloc(
    addPostUsecase:  getIt<AddPostUsecase>(),
    updatePostUsecase: getIt<UpdatePostUsecase>(),
    deletePostUsecase: getIt<DeletePostUsecase>(),
    getUserUsecase: getIt<GetUserUsecase>()
  ));

  // Usecases
  getIt.registerLazySingleton<GetAllPostsUsecase>(() => GetAllPostsUsecase(getIt<PostsRepository>()));
  getIt.registerLazySingleton<AddPostUsecase>(() => AddPostUsecase(getIt<PostsRepository>()));
  getIt.registerLazySingleton<UpdatePostUsecase>(() => UpdatePostUsecase(getIt<PostsRepository>()));
  getIt.registerLazySingleton<DeletePostUsecase>(() => DeletePostUsecase(getIt<PostsRepository>()));
  getIt.registerLazySingleton<GetUserUsecase>(() => GetUserUsecase(getIt<UsersRepository>()));

  // Repositories
  getIt.registerLazySingleton<PostsRepository>(() => PostsRepositoryImpl(
    localDatasource: getIt<PostsLocalDatasource>(),
    remoteDatasource: getIt<PostsRemoteDatasource>(),
    networkInfo: getIt<NetworkInfo>()
  ));
  getIt.registerLazySingleton<UsersRepository>(() => UsersRepositoryImpl(
    networkInfo: getIt<NetworkInfo>(),
    remoteDatasource: getIt<UsersRemoteDatasource>(),
    localDatasource: getIt<UsersLocalDatasource>()
  ));

  // Datasources
  getIt.registerLazySingleton<PostsLocalDatasource>(() => PostsLocalDatasourceImpl(getIt<SharedPreferences>()));
  getIt.registerLazySingleton<PostsRemoteDatasource>(() => PostsRemoteDatasourceImpl(getIt<Dio>()));
  getIt.registerLazySingleton<UsersLocalDatasource>(() => UsersLocalDatasourceImpl(getIt<SharedPreferences>()));
  getIt.registerFactory<UsersRemoteDatasource>(() => UsersRemoteDatasourceImpl(getIt<Dio>()));

  // Core
  getIt.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(getIt<InternetConnectionChecker>()));

  // External
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  getIt.registerLazySingleton<SharedPreferences>(() => prefs);
  
  final Dio dio = Dio(BaseOptions(
    baseUrl: baseUrl,
    headers: <String, String>{
      "Content-Type": "application/json"
    }
  ));
  getIt.registerLazySingleton<Dio>(() => dio);

  getIt.registerFactory<InternetConnectionChecker>(() => InternetConnectionChecker.createInstance());

}