import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/errors/failures.dart';
import '../../../../../core/strings/failure_messages.dart';
import '../../../../../core/strings/success_messages.dart';
import '../../../../../core/usecases/get_user_usecase.dart';
import '../../../../users/domain/entities/user_entity.dart';
import '../../../domain/usecases/add_post_usecase.dart';
import '../../../domain/usecases/delete_post_usecase.dart';
import '../../../domain/usecases/update_post_usecase.dart';
import 'single_post_events.dart';
import 'single_post_states.dart';

class SinglePostBloc extends Bloc<SinglePostEvents, SinglePostStates>{
  SinglePostBloc({
    required final AddPostUsecase addPostUsecase,
    required final UpdatePostUsecase updatePostUsecase,
    required final DeletePostUsecase deletePostUsecase,
    required final GetUserUsecase getUserUsecase,
  }): super(SinglePostInitialState()){
    on<SinglePostEvents>((final SinglePostEvents event, final Emitter<SinglePostStates> emit) async{
      if(event is GetUserEvent){
        emit(SinglePostLoadingUserState());
        (await getUserUsecase(event.id)).fold(
          (final Failure failure) => emit(SinglePostGetUserErrorState(_mapFailureToMessage(failure))),
          (final UserEntity user) => emit(SinglePostGetUserSuccessState(user))
        );
      }
      else if(event is DeletePostEvent){
        emit(SinglePostDeletingState());
        (await deletePostUsecase(event.id)).fold(
          (final Failure failure) => emit(SinglePostDeletingFailedState(_mapFailureToMessage(failure))),
          (final Unit unit) => emit(SinglePostDeletingSuccessState(deleteMessage))
        );
      }
      else if(event is UpdatePostEvent){
        emit(SinglePostUpdatingState());
        (await updatePostUsecase(event.post)).fold(
          (final Failure failure) => emit(SinglePostUpdatingFailedState(_mapFailureToMessage(failure))),
          (final Unit unit) => emit(SinglePostUpdatingSuccessState(updateMessage))
        );
      }
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