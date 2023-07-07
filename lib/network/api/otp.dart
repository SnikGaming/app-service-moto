import 'package:app/components/value_app.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'dart:math';

int generateRandomNumber() {
  Random random = Random();
  int min = 10000; // Giá trị nhỏ nhất có 5 chữ số
  int max = 99999; // Giá trị lớn nhất có 5 chữ số
  return min + random.nextInt(max - min);
}

enum eOtp { register, forgotpassword }

Future<bool> sendOTP(
    {required String email,
    required String otp,
    String? subject = 'OTP Verification',
    eOtp? type = eOtp.forgotpassword}) async {
  String username = mailService;
  String password = keyService;
  final smtpServer = gmail(username, password);
  String bodyMail = '';
  if (type == eOtp.forgotpassword) {
    bodyMail =
        '<!DOCTYPE html><html><head><meta charset="UTF-8"/><title>Mã OTP Xác thực</title></head><body><div style="font-family: Arial, sans-serif; font-size: 14px"><p>Kính gửi khách hàng thân mến,</p><p>Chúng tôi xin gửi mã OTP (One-Time Password) để xác thực quá trình đăng nhập vào ứng dụng SNIK Sửa Xe. Vui lòng sử dụng mã OTP sau đây để hoàn thành quá trình xác thực:</p><p style="font-size: 18px; font-weight: bold">Mã OTP của bạn là: $otp</p><p>Xin lưu ý rằng mã OTP này chỉ có hiệu lực trong một thời gian giới hạn và chỉ sử dụng cho mục đích xác thực đăng nhập. Vui lòng không chia sẻ mã OTP này với bất kỳ ai, bao gồm cả đội ngũ hỗ trợ của chúng tôi.</p><p>Nếu bạn không yêu cầu mã OTP này, xin hãy bỏ qua thông báo này và đảm bảo bảo mật thông tin đăng nhập của mình.</p><p>Trân trọng,</p><p>Đội ngũ SNIK Sửa Xe</p><br/><hr/><p style="font-size: 12px">Hình ảnh minh họa:</p><img src="https://gamek.mediacdn.vn/133514250583805952/2022/5/2/photo-1-1651424647338437442924.jpeg" alt="Hình ảnh minh họa" style="max-width: 400px"/><br/><hr/><p style="font-size: 12px">Liên kết:</p><a href="https://example.com">Truy cập SNIK Sửa Xe</a></div></body></html>';
  } else {
    bodyMail =
        '<!DOCTYPE html><html><head><meta charset="UTF-8"/><title>Mã OTP Xác thực đăng ký</title></head><body><div style="font-family: Arial, sans-serif; font-size: 14px"><p>Kính gửi khách hàng thân mến,</p><p>Chúng tôi xin gửi mã OTP (One-Time Password) để xác thực quá trình đăng ký vào ứng dụng SNIK Sửa Xe. Vui lòng sử dụng mã OTP sau đây để hoàn thành quá trình xác thực:</p><p style="font-size: 18px; font-weight: bold">Mã OTP của bạn là: $otp</p><p>Xin lưu ý rằng mã OTP này chỉ có hiệu lực trong một thời gian giới hạn và chỉ sử dụng cho mục đích xác thực đăng ký. Vui lòng không chia sẻ mã OTP này với bất kỳ ai, bao gồm cả đội ngũ hỗ trợ của chúng tôi.</p><p>Nếu bạn không yêu cầu mã OTP này, xin hãy bỏ qua thông báo này và đảm bảo bảo mật thông tin đăng nhập của mình.</p><p>Trân trọng,</p><p>Đội ngũ SNIK Sửa Xe</p><br/><hr/><p style="font-size: 12px">Hình ảnh minh họa:</p><img src="https://gamek.mediacdn.vn/133514250583805952/2022/5/2/photo-1-1651424647338437442924.jpeg" alt="Hình ảnh minh họa" style="max-width: 400px"/><br/><hr/><p style="font-size: 12px">Liên kết:</p><a href="https://example.com">Truy cập SNIK Sửa Xe</a></div></body></html>';
  }
  final message = Message()
    ..from = Address(username)
    ..recipients.add(email) // Recipient's email address
    ..subject = subject
    ..html = bodyMail;
  // ..text =
  //     'Kính gửi khách hàng thân mến,\n\nChúng tôi xin gửi mã OTP (One-Time Password) để xác thực quá trình đăng nhập vào ứng dụng SNIK Sửa Xe. Vui lòng sử dụng mã OTP sau đây để hoàn thành quá trình xác thực:\n\nMã OTP của bạn là: $otp\n\nXin lưu ý rằng mã OTP này chỉ có hiệu lực trong một thời gian giới hạn và chỉ sử dụng cho mục đích xác thực đăng nhập. Vui lòng không chia sẻ mã OTP này với bất kỳ ai, bao gồm cả đội ngũ hỗ trợ của chúng tôi.\nNếu bạn không yêu cầu mã OTP này, xin hãy bỏ qua thông báo này và đảm bảo bảo mật thông tin đăng nhập của mình.\n\nTrân trọng,\nĐội ngũ SNIK Sửa Xe';

  try {
    final sendReport = await send(message, smtpServer);
    // print('Message sent: ' + sendReport.toString());
    return true;
  } catch (e) {
    return false;
  }
}
