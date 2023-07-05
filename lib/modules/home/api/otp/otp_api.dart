import '../APIBASE.dart';

class APIOtp {
  static Future<bool> createOtp(
      {required String email, required String otp}) async {
    try {
      final response = await ApiBase.post(
          path: '/api/otp', data: {"email": email, "otp": otp});

      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<int> checkOtp(
      {required String email, required String otp}) async {
    try {
      final response = await ApiBase.post(
          path: '/api/otp-check', data: {"email": email, "otp": otp});

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
