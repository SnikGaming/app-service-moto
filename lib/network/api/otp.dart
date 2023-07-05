import 'package:app/components/value_app.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:app/components/message/message.dart' as mes;
import 'dart:math';

int generateRandomNumber() {
  Random random = Random();
  int min = 10000; // Giá trị nhỏ nhất có 5 chữ số
  int max = 99999; // Giá trị lớn nhất có 5 chữ số
  return min + random.nextInt(max - min);
}

Future<bool> sendOTP(
    {required String email,
    required String otp,
    String? subject = 'OTP Verification'}) async {
  String username = mailService;
  String password = keyService;
  final smtpServer = gmail(username, password);
  final message = Message()
    ..from = Address(username)
    ..recipients.add(email) // Recipient's email address
    ..subject = subject
    ..text =
        'Kính gửi khách hàng thân mến,\n\nChúng tôi xin gửi mã OTP (One-Time Password) để xác thực quá trình đăng nhập vào ứng dụng SNIK Sửa Xe. Vui lòng sử dụng mã OTP sau đây để hoàn thành quá trình xác thực:\n\nMã OTP của bạn là: $otp\n\nXin lưu ý rằng mã OTP này chỉ có hiệu lực trong một thời gian giới hạn và chỉ sử dụng cho mục đích xác thực đăng nhập. Vui lòng không chia sẻ mã OTP này với bất kỳ ai, bao gồm cả đội ngũ hỗ trợ của chúng tôi.\nNếu bạn không yêu cầu mã OTP này, xin hãy bỏ qua thông báo này và đảm bảo bảo mật thông tin đăng nhập của mình.\n\nTrân trọng,\nĐội ngũ SNIK Sửa Xe';

  try {
    final sendReport = await send(message, smtpServer);
    // print('Message sent: ' + sendReport.toString());
    return true;
  } catch (e) {
    print('Error sending email: $e');
    return false;
  }
}
