// ignore_for_file: deprecated_member_use, must_be_immutable, library_private_types_in_public_api

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../components/button/button.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

enum Gender { male, female, other }

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  String _avatarUrl = '';
  Gender _gender = Gender.male;
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
                  physics: const NeverScrollableScrollPhysics(),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 50,
                      ),
                      GestureDetector(
                        onTap: () async {
                          final pickedFile = await ImagePicker()
                              .getImage(source: ImageSource.gallery);
                          setState(() {
                            _avatarUrl = pickedFile!.path;
                          });
                        },
                        child: CircleAvatar(
                          backgroundImage: _avatarUrl.isNotEmpty
                              ? FileImage(File(_avatarUrl))
                              : null,
                          radius: 60.0,
                          child: _avatarUrl.isEmpty
                              ? const Icon(Icons.person)
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
                      // DropdownButtonFormField<String>(
                      //   decoration: InputDecoration(
                      //     labelText: 'Gender',
                      //     border: OutlineInputBorder(
                      //       borderRadius: BorderRadius.circular(10),
                      //     ),
                      //   ),
                      //   value: _selectedGender,
                      //   onChanged: (value) {
                      //     setState(() {
                      //       _selectedGender = value;
                      //     });
                      //   },
                      //   items: _genderList.map((gender) {
                      //     return DropdownMenuItem<String>(
                      //       value: gender,
                      //       child: Text(gender),
                      //     );
                      //   }).toList(),
                      // ),
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
