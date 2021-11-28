import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:imagecaptioning/src/model/user.dart';

abstract class UserBehavior {
  Future<User> authenticate(
      {required String username, required String password});
  Future<User> registerDefault(
      {required String username,
      required String password,
      required String email});
}

class DataRepository extends UserBehavior {
  final Dio _dio = Dio();

  final _baseUrl = 'http://13.250.109.141';

  @override
  Future<User> authenticate(
      {required String username, required String password}) async {
    Response userData = await _dio.post(_baseUrl + '/users/authenticate',
        data: {'Username': username, 'Password': password});

    print('User Info: ${userData.data}');

    UserMessage userMessage = UserMessage.fromJson(userData.data);
    print(userMessage.data.toString());
    User user = User.fromJson(parseJwt(userMessage.data.toString()));
    Map<String, dynamic> map = parseJwt(userMessage.data.toString());
    print(map);
    print(user.id);
    print(user.name);
    print(user.email);
    print(user.role);
    return user;
  }

  Map<String, dynamic> parseJwt(String token) {
    final parts = token.split('.');
    if (parts.length != 3) {
      throw Exception('invalid token');
    }

    final payload = _decodeBase64(parts[1]);
    final payloadMap = json.decode(payload);
    if (payloadMap is! Map<String, dynamic>) {
      throw Exception('invalid payload');
    }

    return payloadMap;
  }

  String _decodeBase64(String str) {
    String output = str.replaceAll('-', '+').replaceAll('_', '/');

    switch (output.length % 4) {
      case 0:
        break;
      case 2:
        output += '==';
        break;
      case 3:
        output += '=';
        break;
      default:
        throw Exception('Illegal base64url string!"');
    }

    return utf8.decode(base64Url.decode(output));
  }

  @override
  Future<User> registerDefault(
      {required String username,
      required String password,
      required String email}) async {
    Response userData = await _dio.post(_baseUrl + '/users/registrationdefault',
        data: {
          'user_name': username,
          'user_email': email,
          'user_password': password
        });

    print('User Info: ${userData.data}');

    UserMessage userMessage = UserMessage.fromJson(userData.data);
    print(userMessage.data.toString());
    User user = User.fromJson(parseJwt(userMessage.data.toString()));
    Map<String, dynamic> map = parseJwt(userMessage.data.toString());
    print(map);
    return user;
  }
}
