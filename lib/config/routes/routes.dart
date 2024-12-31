import 'package:flutter/material.dart';

import '../../features/posts/domain/entities/post_entity.dart';
import '../../features/posts/presentation/pages/posts_page.dart';
import '../../features/posts/presentation/pages/single_post_page.dart';
import '../../features/users/domain/entities/user_entity.dart';
import '../../features/users/presentation/pages/user_page.dart';

abstract class AppRoutes{
  static Route onGenerateRoute(final RouteSettings route){
    switch(route.name){
      case "/":
        return _materialPageRoute(const PostsPage());
      case "/single_post":
        return _materialPageRoute(SinglePostPage(route.arguments as PostEntity));
      case "/user_page":
        return _materialPageRoute(UserPage(route.arguments as UserEntity));
    }
    return _materialPageRoute(const PostsPage());
  }

  static MaterialPageRoute _materialPageRoute(final Widget view)
  => MaterialPageRoute(builder: (final BuildContext _) => view);

}