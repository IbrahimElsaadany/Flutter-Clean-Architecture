import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/confirmation_popup.dart';
import '../../../../core/utils/snackbar_message.dart';
import '../../../../core/widgets/refresh_background.dart';
import '../../domain/entities/post_entity.dart';
import '../bloc/single_post/single_post_bloc.dart';
import '../bloc/single_post/single_post_events.dart';
import '../bloc/single_post/single_post_states.dart';
import '../widgets/default_outlines.dart';

class SinglePostPage extends StatelessWidget {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _bodyController = TextEditingController();
  final PostEntity _post;
  SinglePostPage(
    this._post,
    {super.key}
  );

  @override
  Scaffold build(BuildContext context) {
    _titleController.text = _post.title;
    _bodyController.text = _post.body;
    BlocProvider.of<SinglePostBloc>(context).add(GetUserEvent(_post.userId));
    return Scaffold(
      appBar: AppBar(title: const Text("Single Post")),
      body: BlocConsumer<SinglePostBloc, SinglePostStates>(
        listener: (final BuildContext context, final SinglePostStates state) {
          if(state is SinglePostUpdatingFailedState || state is SinglePostDeletingFailedState)
            SnackBarMessage.showErrorSnackBar(
              context: context,
              message: (state as dynamic).message
            );
          
          if(state is SinglePostUpdatingSuccessState || state is SinglePostDeletingSuccessState){
            SnackBarMessage.showSuccessSnackBar(
              context: context,
              message: (state as dynamic).message
            );
            Navigator.pushNamedAndRemoveUntil(context, "/", (final Route<dynamic> route) => route.isFirst);
          }
        },
        builder: (final BuildContext context, final SinglePostStates state) {
          if(state is SinglePostGetUserErrorState) return refreshBackground(state.message);
          else if(state is SinglePostGetUserSuccessState) return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  _post.title,
                  style: Theme.of(context).textTheme.titleLarge,
                  textAlign: TextAlign.center,
                ),
                defaultDivider,
                Text(
                  _post.body
                ),
                defaultDivider,
                Row(
                  children: [
                    Text(
                      "By: ",
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    InkWell(
                      onTap: () => Navigator.pushNamed(context, "/user_page", arguments: state.user!),
                      child: Text(
                        state.user!.name,
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                    )
                  ],
                ),
                defaultDivider,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <ElevatedButton>[
                    ElevatedButton.icon(
                      onPressed: () => showDialog(
                        context: context,
                        builder: (final BuildContext context) => AlertDialog(
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              TextFormField(
                                controller: _titleController,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder()
                                ),
                              ),
                              defaultSpacer,
                              TextFormField(
                                controller: _bodyController,
                                minLines: 3,
                                maxLines: 3,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder()
                                ),
                              ),
                              defaultSpacer,
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                  BlocProvider.of<SinglePostBloc>(context).add(UpdatePostEvent(
                                    PostEntity(
                                      userId: _post.userId,
                                      id: _post.id,
                                      title: _titleController.text,
                                      body: _bodyController.text
                                    )
                                  ));
                                },
                                style: ElevatedButton.styleFrom(
                                  minimumSize: const Size(double.infinity, 40.0)
                                ),
                                child: const Text("Save")
                              )
                            ],
                          ),
                        )
                      ),
                      icon: const Icon(Icons.edit),
                      label: const Text("Update"),
                    ),
                    ElevatedButton.icon(
                      onPressed: () => ConfirmationPopup.showDeletePopup(
                        context,
                        message: "Are you sure to delete this post?",
                        func: () => BlocProvider.of<SinglePostBloc>(context).add(DeletePostEvent(_post.id!))
                      ),
                      icon: const Icon(Icons.delete),
                      label: const Text("Delete"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.red,
                        foregroundColor: AppColors.floor
                      )
                    ),
                  ],
                )
              ],
            ),
          );
          else return Center(child: CircularProgressIndicator());
        }
      ),
    );
  }
}