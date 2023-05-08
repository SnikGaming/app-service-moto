import 'dart:io';

import 'common.dart';

void register(String name, String phone, String gender, File imageFile) async {
  sendProfile(name, phone, gender, imageFile, "",
      "http://192.168.1.14:8000/api/dangky-up");
}

void update(String name, String phone, String gender, File imageFile,
    String token) async {
  sendProfile(name, phone, gender, imageFile, token,
      "http://192.168.1.14:8000/api/update-profile");
}
