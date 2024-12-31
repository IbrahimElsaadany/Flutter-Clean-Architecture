import '../../../domain/entities/post_entity.dart';

abstract class SinglePostEvents{}

class DeletePostEvent extends SinglePostEvents{
  final int id;

  DeletePostEvent(this.id);
}

class UpdatePostEvent extends SinglePostEvents{
  final PostEntity  post;

  UpdatePostEvent(this.post);
}

class GetUserEvent extends SinglePostEvents{
  final int id;

  GetUserEvent(this.id);
}