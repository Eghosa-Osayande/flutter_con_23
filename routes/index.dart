import 'dart:io';

import 'package:dart_frog/dart_frog.dart';

Response onRequest(RequestContext context) {
  return Response(
    body: _indexHTML(),
    headers: {
      HttpHeaders.contentTypeHeader: 'text/html',
    },
  );
}

String _indexHTML() => '''
<!DOCTYPE html>
<html>
<head>
    <title>Welcome to Dart Frog!</title>
</head>
<body>
  Welcome to Dart Frog!
   <div>
    <a href="/signup">Sign Up</a>
   </div>
   <div>
    <a href="/login">Login</a>
   </div>
</body>
</html>

''';
