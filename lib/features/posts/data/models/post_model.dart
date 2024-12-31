import '../../domain/entities/post_entity.dart';

class PostModel extends PostEntity{
  PostModel({
    super.id,
    required super.userId,
    required super.title,
    required super.body
  });

  factory PostModel.fromJson(final Map<String, dynamic> json)
  => PostModel(
    id: json["id"],
    userId: json["userId"],
    title: json["title"],
    body: json["body"]
  );

  Map<String, dynamic> toJson()
  => <String, dynamic>{
    "id": id,
    "userId": userId,
    "title": title,
    "body": body
  };
}