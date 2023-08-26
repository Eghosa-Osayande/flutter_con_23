import 'dart:async';

class UserModel {
  UserModel({
    required this.name,
    required this.passWord,
  });

  final String name;
  final String passWord;
}

abstract class UserRepository {
  Future<UserModel?> getUser(String name, String password);

  Future<UserModel> createUser(String name, String password);

  Future<UserModel?> getUserWithToken(String token);
  
  Future<String> login(UserModel user);
}
