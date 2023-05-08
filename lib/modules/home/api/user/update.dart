import 'dart:io';
import 'package:dio/dio.dart';

void register(String name, String phone, String gender, File imageFile) async {
  // Tạo đối tượng Dio
  Dio dio = new Dio();

  // Tạo đối tượng FormData
  FormData formData = new FormData();

  // Thêm ảnh vào FormData
  formData.files
      .add(MapEntry("image", await MultipartFile.fromFile(imageFile.path)));

  // Thêm thông tin khác vào FormData
  formData.fields.add(MapEntry("name", name));
  formData.fields.add(MapEntry("phone", phone));
  formData.fields.add(MapEntry("gender", gender));

  // Gửi FormData lên server
  Response response =
      await dio.post("http://192.168.1.14:8000/api/dangky-up", data: formData);

  // Xử lý kết quả trả về từ server
  print(response.statusCode);
  print(response.data);
}

void update(String name, String phone, String gender, File imageFile,
    String token) async {
  // Tạo đối tượng Dio
  Dio dio = new Dio();

  // Tạo đối tượng FormData
  FormData formData = new FormData();

  // Thêm ảnh vào FormData
  formData.files
      .add(MapEntry("image", await MultipartFile.fromFile(imageFile.path)));

  // Thêm thông tin khác vào FormData
  formData.fields.add(MapEntry("name", name));
  formData.fields.add(MapEntry("phone", phone));
  formData.fields.add(MapEntry("gender", gender));

  // Thêm header chứa token xác thực vào trong request
  dio.options.headers["Authorization"] = "Bearer $token";

  // Gửi FormData lên server
  Response response = await dio
      .put("http://192.168.1.14:8000/api/update-profile", data: formData);

  // Xử lý kết quả trả về từ server
  print(response.statusCode);
  print(response.data);
}
