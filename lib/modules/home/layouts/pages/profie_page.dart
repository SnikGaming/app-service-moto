// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dio/dio.dart';
import 'package:photo_view/photo_view.dart';
import '../../../../components/zoom/image.dart';
import '../../../../preferences/user/user_preferences.dart';

class ProFilePage extends StatefulWidget {
  const ProFilePage({super.key});

  @override
  State<ProFilePage> createState() => _ProFilePageState();
}

class _ProFilePageState extends State<ProFilePage> {
  File? _image;
  void _handleImagePick() async {
    final pickedFile =
        await ImagePicker().getImage(source: ImageSource.gallery);
    setState(() {
      try {
        _image = File(pickedFile!.path);
      } catch (e) {
        print(e);
      }
    });
  }

  void _handleSubmit() async {
    try {
      await register("abc", "0907486653", "betrang@gmail.com", '12345678',
          '12345678', _image!);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Registration successful.'),
        backgroundColor: Colors.green,
      ));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Registration failed: $e'),
        backgroundColor: Colors.red,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SizedBox(
        width: size.width,
        height: size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            zoomImage(
              imageProvider: NetworkImage(
                  'http://192.168.1.14:8000/storage/user/${UserPrefer.getImageUser()}'),
              child: Image.network(
                  'http://192.168.1.14:8000/storage/user/${UserPrefer.getImageUser()}'),
            ),
            GestureDetector(
              onTap: _handleImagePick,
              child: UserPrefer.getImageUser() != null
                  ? CachedNetworkImage(
                      height: 200,
                      width: 200,
                      imageBuilder: (context, imageProvider) => CircleAvatar(
                          backgroundImage: NetworkImage(
                              'http://192.168.1.14:8000/storage/user/${UserPrefer.getImageUser()}')),
                      fit: BoxFit.cover,
                      placeholder: (context, url) =>
                          const Center(child: CircularProgressIndicator()),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                      imageUrl:
                          'http://192.168.1.14:8000/storage/user/${UserPrefer.getImageUser()}',
                    )
                  : CircleAvatar(
                      radius: 60,
                      backgroundColor: Colors.grey,
                      backgroundImage:
                          _image != null ? FileImage(_image!) : null,
                      child: _image == null
                          ? const Icon(
                              Icons.camera_alt,
                              size: 50,
                              color: Colors.white,
                            )
                          : null,
                    ),
            ),
            TextButton(onPressed: _handleSubmit, child: const Text('Save'))
          ],
        ),
      ),
    );
  }
}

Future<void> register(String name, String phone, String email, String password,
    String c_password, File imageFile) async {
  // Tạo đối tượng Dio
  Dio dio = Dio();

  // Tạo đối tượng FormData
  FormData formData = FormData();

  // Thêm ảnh vào FormData
  formData.files
      .add(MapEntry("image", await MultipartFile.fromFile(imageFile.path)));

  // Thêm thông tin khác vào FormData
  formData.fields.add(MapEntry("name", name));
  // formData.fields.add(MapEntry("phone", phone));
  formData.fields.add(MapEntry("password", password));
  formData.fields.add(MapEntry("c_password", c_password));

  formData.fields.add(MapEntry("email", email));

  // Gửi FormData lên server
  try {
    Response response =
        await dio.post("http://192.168.1.14:8000/api/dangky", data: formData);
    // Xử lý kết quả trả về từ server
    if (response.statusCode == 200) {
      // Đăng ký thành công
      print('Đăng ký thành công!');
    } else {
      // Đăng ký không thành công
      print('Đăng ký không thành công!');
    }
  } catch (e) {
    // Xử lý lỗi khi gửi request
    print('Đăng ký thất bại: $e');
  }
}
