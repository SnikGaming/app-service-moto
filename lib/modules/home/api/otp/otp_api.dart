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
}
