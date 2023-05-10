import 'dart:io';

import 'package:dio/dio.dart';

import '../../../../components/convert/rd_name.dart';
import '../APIBASE.dart';

class APIAuthUser {
  static register({
    String? name,
    required String email,
    required String password,
    required String c_password,
  }) async {
    name = randomName();
    var data = {
      "name": name,
      "email": email,
      "password": password,
      "c_password": c_password
    };
    if (password != c_password) {
      return 401;
    }
    try {
      final response = await ApiBase.post( path: '/api/register/',data: data);
      if (response.statusCode == 200) {
        return 200;
      }
      return 400;
    } catch (e) {
      return 400;
    }
  }

  static update(
      {String? name,
      String? phone,
      String? address,
      File? imageFile,
      String? gender}) async {
    FormData formData = FormData();
    if (imageFile != null) {
      formData.files
          .add(MapEntry("image", await MultipartFile.fromFile(imageFile.path)));
    }
    if (name != null) {
      formData.fields.add(MapEntry("name", name));
    }
    if (gender != null) {
      formData.fields.add(MapEntry("gender", gender));
    }
    if (phone != null) {
      formData.fields.add(MapEntry("phone", phone));
    }
    // formData.fields.add(MapEntry("password", password));
    // formData.fields.add(MapEntry("c_password", c_password));
    if (address != null) {
      formData.fields.add(MapEntry("address", address));
    }
    try {
      final response =
          await ApiBase.post(path: '/api/dangky-up/', data: formData);
      if (response.statusCode == 200) {
        return 200;
      }
      return 400;
    } catch (e) {
      return 400;
    }
  }
}
