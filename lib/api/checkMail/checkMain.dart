import '../APIBASE.dart';

class APICheckValue {
  static Future<int> checkMail({required String email}) async {
    try {
      final response = await ApiBase.post(
          path: '/api/checkMail', data: {"email": email.toLowerCase().trim()});
      if (response.statusCode == 200) {
        return 200;
      }
      return 400;
    } catch (e) {
      return 404;
    }
  }
}
