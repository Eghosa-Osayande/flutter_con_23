import 'dart:async';

class PostModel {
  PostModel({
    required this.title,
    required this.body,
  });

  final String title;
  final String body;
}

abstract class PostRepository {
  Future<PostModel?> getPostById(String id);

  Future<List<PostModel>> getAllPost();
}
