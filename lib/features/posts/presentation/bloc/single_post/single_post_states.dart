import '../../../../users/domain/entities/user_entity.dart';

abstract class SinglePostStates{
  final UserEntity? user;

  SinglePostStates({this.user});
}

class SinglePostInitialState extends SinglePostStates{}

class SinglePostUpdatingState extends SinglePostStates{}

class SinglePostUpdatingFailedState extends SinglePostStates{
  final String message;

  SinglePostUpdatingFailedState(this.message);
}

class SinglePostUpdatingSuccessState extends SinglePostStates{
  final String message;

  SinglePostUpdatingSuccessState(this.message);
}

class SinglePostDeletingState extends SinglePostStates{}

class SinglePostDeletingFailedState extends SinglePostStates{
  final String message;

  SinglePostDeletingFailedState(this.message);
}

class SinglePostDeletingSuccessState extends SinglePostStates{
  final String message;

  SinglePostDeletingSuccessState(this.message);
}

class SinglePostLoadingUserState extends SinglePostStates{}

class SinglePostGetUserErrorState extends SinglePostStates{
  final String message;

  SinglePostGetUserErrorState(this.message);
}

class SinglePostGetUserSuccessState extends SinglePostStates{
  SinglePostGetUserSuccessState(final UserEntity user): super(user: user);
}