import '../APIBASE.dart';

class APIForgotPassword {
  static Future<int> forgotPassword(
      {required String email,
      required String password,
      required String c_password}) async {
    try {
      final response = await ApiBase.post(path: '/api/forgotPassword', data: {
        "email": email,
        "password": password,
        "password_confirmation": c_password
      });

      if (response.statusCode == 200) {
        return 200;
      } else {
        return 404;
      }
    } catch (e) {
      return 404;
    }
  }
}
