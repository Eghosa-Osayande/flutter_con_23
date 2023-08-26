import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:my_project/posts_repository/posts_repository.dart';
import 'package:my_project/user_repository/user_repository.dart';

class _PostRepoImpl implements PostRepository {
  final Map<String, PostModel> _posts = {
    '1': PostModel(
      id: '1',
      title: 'Post 1',
      body: 'Post Body of Post 1',
    ),
    '2': PostModel(
      id: '2',
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
  return handler.use(
    provider(
      (context) {
        return _postsRepo ??= _PostRepoImpl();
      },
    ),
  ).use(
    (handler) {
      return (context) async {
        final cookies = _getCookies(context);
        print(cookies);
        final authToken = cookies?['authToken'];

        if (authToken == null) {
          return Response.movedPermanently(location: '/login');
        }

        final userRepo = context.read<UserRepository>();
        final user = await userRepo.getUserWithToken(authToken);

        if (user == null) {
          return Response.movedPermanently(location: '/login');
        }

        return handler(context);
      };
    },
  );
}

Map<String, String>? _getCookies(RequestContext context) {
  return context.request.headers[HttpHeaders.cookieHeader]?.split(';').fold(
    {},
    (previousValue, element) {
      try {
        final split = element.split('=');
        previousValue?.addAll(
          {
            split.first.trim(): split.last
          },
        );
      } finally {
        return previousValue?..addAll({});
      }
    },
  );
}
