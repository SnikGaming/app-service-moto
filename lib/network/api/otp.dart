import 'package:app/components/value_app.dart';
import 'package:flutter/material.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'dart:math';

int generateRandomNumber() {
  Random random = Random();
  int min = 10000; // Giá trị nhỏ nhất có 5 chữ số
  int max = 99999; // Giá trị lớn nhất có 5 chữ số
  return min + random.nextInt(max - min);
}

enum eOtp { register, forgotpassword, sp }

dangGuiMail(context) => showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const AlertDialog(
          content: Text('Đang gửi email...'),
        );
      },
    );
// String generateTableHtml(List<Product> products) {
//   String tableHtml =
//       '<thead><tr><th>Tên sản phẩm</th><th>Giá</th></tr></thead>';

//   for (var product in products) {
//     tableHtml += '<tr><td>${product.name}</td><td>${product.price}</td></tr>';
//   }

//   return tableHtml;
// }

Future<bool> sendOTP(
    {required String email,
    required String otp,
    String? listSP,
    String? toTal,
    String? subject = 'OTP Verification',
    eOtp? type = eOtp.forgotpassword}) async {
  String username = mailService;
  String password = keyService;
  String url_image =
      '"https://media.giphy.com/media/c8jNmgY5fcUfZMZx5G/giphy.gif"';
  final smtpServer = gmail(username, password);
  String bodyMail = '';
  if (type == eOtp.forgotpassword) {
    bodyMail =
        '<!DOCTYPE html><html><head><meta charset="UTF-8"><title>Khôi phục mật khẩu - OTP</title><style>/* CSS */body {font-family: Arial, sans-serif;background: linear-gradient(to bottom, #8A2BE2, #9400D3);padding: 20px;}.container {max-width: 600px;margin: 0 auto;background-color: #fff;padding: 20px;border: 1px solid #ccc;border-radius: 16px;}.logo {text-align: center;margin-bottom: 20px;}.otp {background-color: #eee;padding: 10px;text-align: center;font-size: 24px;margin-bottom: 20px;font-weight: bold;}.contact-info {text-align: left;margin-top: 30px;font-size: 14px;}.contact-info p {margin: 0;}.footer {font-size: 14px;text-align: center;margin-top: 30px;color: #fff;font-weight: bold;}.form-input {background-color: #f9f9f9;border: 1px solid #ccc;padding: 8px;color: #333;}.form-label {font-weight: bold;color: #333;}</style></head><body><div class="container"><div class="logo"><img src=$url_image alt="Logo"></div><h1>Khôi phục mật khẩu</h1><p>Xin chào,</p><p>Bạn đã yêu cầu khôi phục mật khẩu cho ứng dụng bán phụ tùng xe và đặt lịch của chúng tôi.</p><p>Dưới đây là mã OTP để xác nhận:</p><div class="otp">$otp</div><p>Nếu bạn không yêu cầu khôi phục mật khẩu, vui lòng bỏ qua email này.</p><div class="contact-info"><p><strong>Thông tin liên hệ:</strong></p><p><strong>Email:</strong> <a href="mailto:tranthoilong@gmail.com">tranthoilong@gmail.com</a></p><p><strong>Số điện thoại:</strong> <a href="tel:+84383892964">0383892964</a></p></div><p class="footer">Bạn nhận được email này vì bạn đã yêu cầu khôi phục mật khẩu. Nếu bạn không nhớ yêu cầu này, xin vui lòng liên hệ với chúng tôi.</p></div></body></html>';
  } else if (type == eOtp.register) {
    bodyMail =
        '<!DOCTYPE html><html><head><meta charset="UTF-8"><title>Xác nhận đăng ký tài khoản - OTP</title><style>/* CSS */body {font-family: Arial, sans-serif;background: linear-gradient(to bottom, #8A2BE2, #9400D3);padding: 20px;}.container {max-width: 600px;margin: 0 auto;background-color: #fff;padding: 20px;border: 1px solid #ccc;border-radius: 16px;}.logo {text-align: center;margin-bottom: 20px;}.otp {background-color: #eee;padding: 10px;text-align: center;font-size: 24px;margin-bottom: 20px;font-weight: bold;}.contact-info {text-align: left;margin-top: 30px;font-size: 14px;}.contact-info p {margin: 0;}.footer {font-size: 14px;text-align: center;margin-top: 30px;color: #fff;font-weight: bold;}.form-input {background-color: #f9f9f9;border: 1px solid #ccc;padding: 8px;color: #333;}.form-label {font-weight: bold;color: #333;}</style></head><body><div class="container"><div class="logo"><img src=$url_image alt="Logo"></div><h1>Xác nhận đăng ký tài khoản</h1><p>Xin chào,</p><p>Cảm ơn bạn đã sử dụng ứng dụng bán phụ tùng xe và đặt lịch của chúng tôi.</p><p>Dưới đây là mã OTP để xác nhận đăng ký tài khoản:</p><div class="otp">$otp</div><p>Trân trọng,</p><p>Đội ngũ hỗ trợ ứng dụng bán phụ tùng xe và đặt lịch</p><div class="contact-info"><p><strong>Thông tin liên hệ:</strong></p><p><strong>Email:</strong> <a href="mailto:tranthoilong@gmail.com">tranthoilong@gmail.com</a></p><p><strong>Số điện thoại:</strong> <a href="tel:+84383892964">0383892964</a></p></div><p class="footer">Bạn nhận được email này vì bạn đã đăng ký tài khoản. Nếu bạn không thực hiện hành động này, xin vui lòng liên hệ với chúng tôi.</p></div></body></html>';
  } else {
    bodyMail =
        '<!DOCTYPE html><html><head><meta charset="UTF-8"><title>Xác nhận mua hàng thành công</title><style>/* CSS */body {font-family: Arial, sans-serif;background: linear-gradient(to bottom, #8A2BE2, #9400D3);padding: 20px;}.container {max-width: 600px;margin: 0 auto;background-color: #fff;padding: 20px;border: 1px solid #ccc;border-radius: 10px;}h1 {color: #333;text-align: center;}p {color: #555;line-height: 1.5;}.order-details {margin-bottom: 20px;}.order-details table {width: 100%;border-collapse: collapse;}.order-details th,.order-details td {border: 1px solid #ccc;padding: 8px;}.order-details th {background-color: #eee;text-align: left;font-weight: bold;}.total {font-weight: bold;text-align: right;}.cta-button {display: inline-block;background-color: #4CAF50;color: #fff;text-decoration: none;padding: 10px 20px;border-radius: 5px;}</style></head><body><div class="container"><h1>Xác nhận mua hàng thành công</h1><p>Xin chào,</p><p>Cảm ơn bạn đã mua hàng từ chúng tôi. Đơn hàng của bạn đã được xác nhận thành công. Dưới đây là chi tiết đơn hàng:</p><div class="order-details"><table>${listSP}</table></div><p>Tổng tiền: <span class="total">${toTal}</span></p><p>Chúng tôi xin cam kết đảm bảo chất lượng sản phẩm và dịch vụ. Đơn hàng của bạn sẽ được xử lý và giao đến bạn trong thời gian sớm nhất.</p><p>Nếu bạn có bất kỳ câu hỏi hoặc yêu cầu hỗ trợ, đừng ngần ngại liên hệ với chúng tôi qua thông tin dưới đây:</p><p>Địa chỉ: 123 Đường ABC, Thành phố XYZ</p><p>Email: <a href="mailto:tranthoilong@gmail.com">tranthoilong@gmail.com</a></p><p>Số điện thoại: <a href="tel:+84383892964">0383892964</a></p><p>Xin chân thành cảm ơn bạn đã tin tưởng và mua hàng từ chúng tôi. Chúng tôi hy vọng rằng bạn sẽ hài lòng với sản phẩm và dịch vụ của chúng tôi.</p><p>Trân trọng,</p><p>Đội ngũ hỗ trợ mua hàng</p><p style="text-align: center;"><a href="https://example.com" class="cta-button">Trang chủ</a></p></div></body></html>';
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
