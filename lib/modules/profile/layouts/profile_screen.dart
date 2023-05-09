// ignore_for_file: deprecated_member_use, must_be_immutable, library_private_types_in_public_api

import 'dart:io';

import 'package:app/modules/home/api/login/model.dart' as value;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../components/button/button.dart';
import '../../../preferences/user/user_preferences.dart';

class ProfileScreen extends StatefulWidget {
  var data = [];
  ProfileScreen({super.key, required this.data});

  @override
  _ProfileScreenState createState() => _ProfileScreenState(data: data);
}

enum Gender { male, female, other }

class _ProfileScreenState extends State<ProfileScreen> {
  var data = [];

  _ProfileScreenState({required this.data});
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

  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  String _avatarUrl = '';
  Gender _gender = Gender.male;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }

  loadData() {
    _fullNameController.text = data[0].name;
    _emailController.text = data[0].email;

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // print('this is data ${data[0].id}');

    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: size.height,
            width: size.width,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/bg3.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                top: 120, left: 20, right: 20, bottom: 10),
            child: Container(
              height: size.height * .9,
              width: size.width,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                  BoxShadow(
                    color: Colors.white.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: const Offset(0, -3),
                  ),
                ],
                borderRadius: BorderRadius.circular(30),
                color: const Color.fromARGB(255, 250, 246, 246),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SingleChildScrollView(
                  physics: const NeverScrollableScrollPhysics(),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 50,
                      ),
                      // GestureDetector(
                      //   onTap: () async {
                      //     final pickedFile = await ImagePicker()
                      //         .getImage(source: ImageSource.gallery);
                      //     setState(() {
                      //       try {
                      //         _avatarUrl = pickedFile!.path;
                      //       } catch (e) {
                      //         print(e);
                      //       }
                      //     });
                      //   },
                      //   child: CircleAvatar(
                      //     backgroundImage: _avatarUrl.isNotEmpty
                      //         ? FileImage(File(_avatarUrl))
                      //         : null,
                      //     radius: 60.0,
                      //     child: _avatarUrl.isEmpty
                      //         ? const Icon(Icons.person)
                      //         : null,
                      //   ),
                      // ),

                      GestureDetector(
                        onTap: _handleImagePick,
                        child: UserPrefer.getImageUser() != null
                            ? CachedNetworkImage(
                                height: 160,
                                width: 160,
                                imageBuilder: (context, imageProvider) =>
                                    CircleAvatar(
                                        backgroundImage: NetworkImage(
                                            'http://192.168.1.14:8000/storage/user/${UserPrefer.getImageUser()}')),
                                fit: BoxFit.cover,
                                placeholder: (context, url) => const Center(
                                    child: CircularProgressIndicator()),
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

                      const SizedBox(height: 16.0),
                      textFieldInput(
                        controller: _fullNameController,
                        labelText: 'Full Name',
                      ),
                      const SizedBox(height: 16.0),
                      textFieldInput(
                        isReadonly: true,
                        controller: _emailController,
                        labelText: 'Email',
                      ),
                      const SizedBox(height: 16.0),
                      textFieldInput(
                        controller: _phoneController,
                        labelText: 'Phone',
                      ),
                      const SizedBox(height: 16.0),
                      textFieldInput(
                        controller: _addressController,
                        labelText: 'Address',
                      ),
                      const SizedBox(height: 16.0),
                      Column(
                        children: [
                          RadioListTile<Gender>(
                            title: const Text('Male'),
                            value: Gender.male,
                            groupValue: _gender,
                            onChanged: (value) {
                              setState(() {
                                _gender = value!;
                              });
                            },
                          ),
                          RadioListTile<Gender>(
                            title: const Text('Female'),
                            value: Gender.female,
                            groupValue: _gender,
                            onChanged: (value) {
                              setState(() {
                                _gender = value!;
                              });
                            },
                          ),
                          RadioListTile<Gender>(
                            title: const Text('Other'),
                            value: Gender.other,
                            groupValue: _gender,
                            onChanged: (value) {
                              setState(() {
                                _gender = value!;
                              });
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 20.0),
                      SizedBox(
                        width: size.width,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            ButtonCustom(
                              ontap: () => Navigator.pop(context),
                              color: Colors.red,
                              width: size.width * .3,
                              child: const Center(
                                child: Text(
                                  'Cancel',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                            ButtonCustom(
                              color: Colors.green,
                              width: size.width * .3,
                              child: const Center(
                                child: Text(
                                  'Save',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

// ignore: camel_case_types
class textFieldInput extends StatelessWidget {
  TextEditingController controller;
  String labelText;
  bool? isReadonly;
  textFieldInput({
    super.key,
    required this.controller,
    required this.labelText,
    this.isReadonly = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      enabled: !isReadonly!,
      onChanged: (value) {
        if (value.length > 20) {
          controller.text = value.substring(0, 20);
          controller.selection = TextSelection.fromPosition(
              TextPosition(offset: controller.text.length));
        }
      },
      readOnly: isReadonly!,
      decoration: InputDecoration(
        labelText: labelText,
        contentPadding:
            const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.grey),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.blue),
          borderRadius: BorderRadius.circular(10),
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
