import 'package:dart_frog/dart_frog.dart';
import 'package:my_project/user_repository/user_repository.dart';

class _UserRepoImpl implements UserRepository {
  final Map<String, UserModel> _users = {
    'admin': UserModel(
      name: 'admin',
      passWord: '1',
    ),
  };
  
  @override
  Future<UserModel> createUser(String name, String password) async {
    return _users.putIfAbsent(
      name,
      () => UserModel(
        name: name,
        passWord: password,
      ),
    );
  }

  @override
  Future<UserModel?> getUser(String name, String password) async {
    return _users[name];
  }
}

UserRepository? _userRepo;

Handler middleware(Handler handler) {
  return (context) async {
    final response = await handler(context);

    return response;
  }.use(
    provider(
      (context) {
        return _userRepo ??= _UserRepoImpl();
      },
    ),
  );
}
