import 'dart:io';

import 'package:dart_frog/dart_frog.dart';

Response onRequest(RequestContext context, String id) {
  return Response.json(
    statusCode: HttpStatus.notFound, // 404
    body: {
      'id': id,
    },
  );
}
