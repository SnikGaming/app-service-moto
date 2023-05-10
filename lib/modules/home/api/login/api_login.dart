import 'package:app/modules/home/api/login/model.dart';
import 'package:dio/dio.dart';
import '../../../../preferences/user/user_preferences.dart';
import '../APIBASE.dart';

class APIAuth {
  static Data userLogin = Data();

  static Future<int> login(
      {String email = "long@gmail.com", String password = "12345678"}) async {
    try {
      final response = await ApiBase.post(
          path: '/api/login', data: {"email": email, "password": password});
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = response.data;
        final String tempToken = responseData['token'];
        final token = extractToken(tempToken);
        UserPrefer.setToken(value: token!);
        getUser();
        return 200;
      } else {
        throw Exception("Failed to login");
      }
    } catch (e) {
      return 400;
    }
  }

  static Future<Data?> getUser() async {
    // print('this is user ');
    Response response;
    try {
      response = await ApiBase.get(path: '/api/dangky/');
    } catch (e) {
      return null;
    }
    final jsonData = response.data['data'];
    saveUserData(jsonData);
    return Data.fromJson(jsonData);
  }

  static void saveUserData(Map<String, dynamic> jsonData) {
    UserPrefer.setEmail(value: jsonData['email']);
    if (jsonData['image'] != '/storage/user/Null') {
      UserPrefer.setImageUser(value: jsonData['image']);
    } else {
      UserPrefer.removeImageUser();
    }
    UserPrefer.setUserName(value: jsonData['name']);
    UserPrefer.setId(value: jsonData['id']);
  }
}

String? extractToken(String bearerToken) {
  final parts = bearerToken.split(' ');
  return parts.length == 2 ? parts[1] : null;
}
