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
      final existingUser = await userRepo.getUser(name, password);

      if (existingUser !=null) {
        final authToken = await userRepo.login(existingUser);
        return Response.movedPermanently(
          location: '/posts',
          headers: {
            HttpHeaders.setCookieHeader: [
              'authToken=$authToken; Path=/; Max-Age=84000',
            ],
          },
        );
      }

      return Response(
        body: 'User ${name} not found',
        statusCode: HttpStatus.notFound,
      );

    case HttpMethod.get:
      return Response(
        body: _loginHTML(),
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

String _loginHTML() => '''
<!DOCTYPE html>
<html>
<head>
    <title>Login Page</title>
</head>
<body>
    <h2>Login</h2>
    <form action="" method="post">
        <label for="username">Username:</label>
        <input type="text" id="username" name="username" required><br><br>
        <label for="password">Password:</label>
        <input type="password" id="password" name="password" required><br><br>
        <button type="submit">Login</button>
    </form>
    <br>
    <div>
    <a href="/signup">OR Sign up</a>
   </div>
</body>
</html>

''';
