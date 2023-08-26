import 'dart:async';

class PostModel {
  PostModel({
    required this.title,
    required this.body,
    required this.id,
  });

  final String title;
  final String body;
  final String id;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'title': title,
      'body': body,
      'id': id,
    };
  }
}

abstract class PostRepository {
  Future<PostModel?> getPostById(String id);

  Future<List<PostModel>> getAllPost();
}
