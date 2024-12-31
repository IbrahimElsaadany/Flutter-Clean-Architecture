import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";

import "config/routes/routes.dart";
import "config/themes/light_theme.dart";
import "features/posts/presentation/bloc/posts/posts_bloc.dart";
import "features/posts/presentation/bloc/posts/posts_events.dart";
import "features/posts/presentation/bloc/single_post/single_post_bloc.dart";
import "injection_provider.dart";

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await setupDependencyInjection();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  MultiBlocProvider build(final BuildContext context)
  => MultiBlocProvider(
    providers: <BlocProvider>[
      BlocProvider<PostsBloc>(
        create: (final BuildContext context) => getIt<PostsBloc>()..add(GetAllPostsEvent()),
      ),
      BlocProvider<SinglePostBloc>(
        create: (final BuildContext context) => getIt<SinglePostBloc>(),
      ),
    ],
    child: MaterialApp(
      onGenerateRoute: AppRoutes.onGenerateRoute,
      initialRoute: "/",
      theme: lightTheme,
    ),
  );
}