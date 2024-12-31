class PostEntity{
  final int? id;
  final int userId;
  final String title, body;

  PostEntity({
    this.id,
    required this.userId,
    required this.title,
    required this.body,
  });
}