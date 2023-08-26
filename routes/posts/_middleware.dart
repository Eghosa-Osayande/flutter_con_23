import 'package:dart_frog/dart_frog.dart';
import 'package:my_project/posts_repository/posts_repository.dart';

class _PostRepoImpl implements PostRepository {
  
  final Map<String, PostModel> _posts = {
    '1': PostModel(
      title: 'Post 1',
      body: 'Post Body of Post 1',
    ),
    '2': PostModel(
      title: 'Post 2',
      body: 'Post Body of Post 2',
    ),
  };

  @override
  Future<List<PostModel>> getAllPost() async {
    return _posts.values.toList();
  }

  @override
  Future<PostModel?> getPostById(String id) async {
    return _posts[id];
  }
}

PostRepository? _postsRepo;

Handler middleware(Handler handler) {
  return (context) async {
    final response = await handler(context);
    return response;
  }.use(
    provider(
      (context) {
        return _postsRepo ??= _PostRepoImpl();
      },
    ),
  );
}
