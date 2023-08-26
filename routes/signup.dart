import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:my_project/user_repository/user_repository.dart';

Future<Response> onRequest(RequestContext context) async {
  final request = context.request;
  switch (request.method) {
    case HttpMethod.post:
      final fields = (await request.formData()).fields;

      final (
        String name,
        String password
      ) = (
        fields['username']!,
        fields['password']!,
      );
      final userRepo = context.read<UserRepository>();
      final user = await userRepo.getUser(name, password);

      if (user == null) {
        final createdUser = await userRepo.createUser(name, password);
        return Response(
          body: 'Created Account for ${createdUser.name}',
        );
      }

      return Response(
        body: 'User (${name}) already exists',
        statusCode: HttpStatus.notFound,
      );

    case HttpMethod.get:
      return Response(
        body: _signupHTML(),
        headers: {
          HttpHeaders.contentTypeHeader: 'text/html',
        },
      );

    default:
      return Response(
        body: 'Method is not allowed',
        statusCode: HttpStatus.methodNotAllowed,
      );
  }
}

String _signupHTML() => '''
<!DOCTYPE html>
<html>
<head>
    <title>Signup Page</title>
</head>
<body>
    <h2>Sign Up</h2>
    <form action="" method="post">
        <label for="username">Username:</label>
        <input type="text" id="username" name="username" required><br><br>
        <label for="password">Password:</label>
        <input type="password" id="password" name="password" required><br><br>
        <button type="submit">Sign Up</button>
    </form>
</body>
</html>
''';
