import 'package:dart_frog/dart_frog.dart';

Future<Response> onRequest(RequestContext context) async {
  
  final _ = await Future<dynamic>.delayed(
    const Duration(
      milliseconds: 500,
    ),
  );

  return Response(body: 'Posts Page');
}
