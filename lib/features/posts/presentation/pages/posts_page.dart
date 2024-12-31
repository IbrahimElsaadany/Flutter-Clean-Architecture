import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/widgets/refresh_background.dart';
import '../bloc/posts/posts_bloc.dart';
import '../bloc/posts/posts_events.dart';
import '../bloc/posts/posts_states.dart';
import '../widgets/default_outlines.dart';
import '../widgets/post_item.dart';

class PostsPage extends StatelessWidget{
  const PostsPage({super.key});

  @override
  Scaffold build(final BuildContext context)
  => Scaffold(
    appBar: AppBar(title: const Text("Posts"),),
    body: BlocBuilder<PostsBloc, PostsStates>(
      builder: (final BuildContext context, final PostsStates state) {
        if(state is PostsLoadingSuccessState)
          return RefreshIndicator(
            onRefresh: () => _onRefresh(context),
            child: ListView.separated(
              padding: EdgeInsets.symmetric(horizontal: 12.0),
              physics: const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
              itemBuilder: (final BuildContext context, final int i) => postItem(
                context,
                state.posts[i]
              ),
              separatorBuilder: (final BuildContext context, final int i) => defaultDivider,
              itemCount: state.posts.length,
            ),
          );
        else if(state is PostsLoadingFailedState) return refreshBackground(state.message);
        return const Center(child: CircularProgressIndicator());
      }
    )
  );

  Future<void> _onRefresh(final BuildContext context) async
  => BlocProvider.of<PostsBloc>(context).add(RefreshPostsEvent());
}