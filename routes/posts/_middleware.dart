import 'package:dart_frog/dart_frog.dart';

Handler middleware(Handler handler) {
  return (RequestContext context) async {
    // Execute code before request is handled.

    // Forward the request to the respective handler.
    final response = await handler(context);

    // Execute code after request is handled.

    // Return a response.
    return response;
  }.use(
    (handler) {
      return (context) async {
        print('Executes second');
        final response = await handler(context);
        return response;
      };
    },
  ).use(
    (handler) {
      print('Executes first');
      return (context) async {
        final response = await handler(context);
        return response;
      };
    },
  );
}
