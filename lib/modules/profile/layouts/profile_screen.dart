// ignore_for_file: deprecated_member_use, must_be_immutable, library_private_types_in_public_api, use_build_context_synchronously, no_logic_in_create_state

import 'dart:io';

import 'package:app/api/login/model.dart' as value;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../components/button/button.dart';
import '../../../network/connect.dart';
import '../../../preferences/user/user_preferences.dart';
import '../../../api/user/register.dart';

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
      } catch (e) {}
    });
  }

  void _handleSubmit() async {
    var value = _gender == Gender.male
        ? '1'
        : _gender == Gender.female
            ? '0'
            : '-1';
    var response = await APIAuthUser.update(
        name: _fullNameController.text,
        address: _addressController.text,
        phone: _phoneController.text,
        gender: value,
        imageFile: _image);
    if (response == 200) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Chỉnh sửa thành công.💕'),
        backgroundColor: Colors.green,
      ));
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Chỉnh sửa thất bại.💕'),
        backgroundColor: Colors.red,
      ));
    }
  }

  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }

  Gender? _gender;
  loadData() {
    _fullNameController.text = data[0].name;
    _emailController.text = data[0].email;
    _phoneController.text = data[0].phone ?? '';
    _addressController.text = data[0].address ?? '';
    _gender = data[0].gender == 1
        ? Gender.male
        : data[0].gender == 0
            ? Gender.female
            : Gender.other;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
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
                  // physics: const NeverScrollableScrollPhysics(),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 50,
                      ),
                      GestureDetector(
                        onTap: _handleImagePick,
                        child: UserPrefer.getImageUser() != null &&
                                _image == null
                            ? CachedNetworkImage(
                                height: 110,
                                width: 110,
                                imageBuilder: (context, imageProvider) =>
                                    CircleAvatar(
                                        backgroundImage: NetworkImage(
                                            '${ConnectDb.url}${UserPrefer.getImageUser()}')),
                                fit: BoxFit.cover,
                                placeholder: (context, url) => const Center(
                                    child: CircularProgressIndicator()),
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                                imageUrl:
                                    '${ConnectDb.url}${UserPrefer.getImageUser()}',
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
                        labelText: 'Họ & tên',
                      ),
                      const SizedBox(height: 16.0),
                      textFieldInput(
                        isReadonly: true,
                        controller: _emailController,
                        labelText: 'Email',
                      ),
                      const SizedBox(height: 16.0),
                      textFieldInput(
                        keyboardType: TextInputType.phone,
                        controller: _phoneController,
                        labelText: 'Số điện thoại',
                      ),
                      const SizedBox(height: 16.0),
                      textFieldInput(
                        controller: _addressController,
                        labelText: 'Địa chỉ',
                      ),
                      const SizedBox(height: 16.0),
                      Column(
                        children: [
                          RadioListTile<Gender>(
                            title: const Text('Nam'),
                            value: Gender.male,
                            groupValue: _gender,
                            onChanged: (value) {
                              setState(() {
                                _gender = value!;
                              });
                            },
                          ),
                          RadioListTile<Gender>(
                            title: const Text('Nữ'),
                            value: Gender.female,
                            groupValue: _gender,
                            onChanged: (value) {
                              setState(() {
                                _gender = value!;
                              });
                            },
                          ),
                          RadioListTile<Gender>(
                            title: const Text('Khác'),
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
                                  'Hủy',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                            ButtonCustom(
                              ontap: _handleSubmit,
                              color: Colors.green,
                              width: size.width * .3,
                              child: const Center(
                                child: Text(
                                  'Lưu',
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
  TextInputType? keyboardType;
  textFieldInput({
    super.key,
    required this.controller,
    required this.labelText,
    this.keyboardType,
    this.isReadonly = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
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
