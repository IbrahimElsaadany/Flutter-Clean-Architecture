import "package:flutter_bloc/flutter_bloc.dart";

import "../../../../../core/errors/failures.dart";
import "../../../../../core/strings/failure_messages.dart";
import "../../../domain/entities/post_entity.dart";
import "../../../domain/usecases/get_all_posts_usecase.dart";
import "posts_events.dart";
import "posts_states.dart";
class PostsBloc extends Bloc<PostsEvents, PostsStates>{
  final GetAllPostsUsecase _getAllPostsUsecase;

  PostsBloc(this._getAllPostsUsecase): super(PostsInitialState()){
    on<PostsEvents>((final PostsEvents event, final Emitter<PostsStates> emit) async{
      if(event is GetAllPostsEvent || event is RefreshPostsEvent)
        (await _getAllPostsUsecase()).fold(
          (final Failure failure) => emit(PostsLoadingFailedState(_mapFailureToMessage(failure))),
          (final List<PostEntity> posts) => emit(PostsLoadingSuccessState(posts))
        );
    });
  }

  String _mapFailureToMessage(final Failure failure){
    switch(failure.runtimeType){
      case ServerFailure: return serverFailureMessage;
      case OfflineFailure: return offlineFailureMessage;
      case EmptyCacheFailure: return emptyCacheFailureMessage;
      default: return defaultFailureMessage;
    }
  }
}