import 'package:dart_frog/dart_frog.dart';

import 'package:jinja/jinja.dart';

import 'package:jinja/loaders.dart';
import 'package:my_project/posts_repository/posts_repository.dart';

Future<Response> onRequest(RequestContext context) async {
  final environment = Environment(
    loader: FileSystemLoader(
      paths: [
        'templates'
      ],
    ),
  );

  final template = environment.getTemplate(
    'posts/index.html',
  );

  final postRepo = context.read<PostRepository>();

  final posts = await postRepo.getAllPost();
  final postsJson = posts
      .map(
        (e) => e.toJson(),
      )
      .toList();

  return Response(
    body: template.render({
      'title': 'Dart Frog',
      'posts': postsJson,
    }),
    headers: {
      'Content-Type': 'text/html'
    },
  );
}
