import 'dart:io';
import 'package:dio/dio.dart';

void sendProfile(String name, String phone, String gender, File imageFile,
    String token, String apiUrl) async {
  Dio dio = Dio();
  FormData formData = FormData();
  formData.files
      .add(MapEntry("image", await MultipartFile.fromFile(imageFile.path)));
  // Thêm thông tin khác vào FormData
  formData.fields.add(MapEntry("name", name));
  formData.fields.add(MapEntry("phone", phone));
  formData.fields.add(MapEntry("gender", gender));
  // Thêm header chứa token xác thực vào trong request
  dio.options.headers["Authorization"] = "Bearer $token";
  // Gửi FormData lên server
  Response response = await dio.put(apiUrl, data: formData);
  // Xử lý kết quả trả về từ server
  print(response.statusCode);
  print(response.data);
}
