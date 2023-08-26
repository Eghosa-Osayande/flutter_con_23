import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:jinja/jinja.dart';
import 'package:jinja/loaders.dart';
import 'package:my_project/posts_repository/posts_repository.dart';

Future<Response> onRequest(RequestContext context, String id) async {
  final environment = Environment(
    loader: FileSystemLoader(
      paths: [
        'templates'
      ],
    ),
  );

  final template = environment.getTemplate(
    'posts/[id].html',
  );

  print(context.request.uri.queryParameters);

  final postRepo = context.read<PostRepository>();

  final post = await postRepo.getPostById(id);

  if (post != null) {
    return Response(
      body: template.render({
        'title': post.title,
        'body': post.body,
      }),
      headers: {
        'Content-Type': 'text/html'
      },
    );
  } else {
    return Response(
      statusCode: HttpStatus.notFound,
      body: 'Post not found',
    );
  }
}
