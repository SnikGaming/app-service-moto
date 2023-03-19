import 'package:app/components/message/message.dart';
import 'package:app/preferences/user/user_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthWithGoogle {
  static GoogleSignIn googleSignIn = GoogleSignIn(scopes: ['email']);
  final FirebaseAuth _auth = FirebaseAuth.instance;

  /// Hàm thực hiện đăng xuất người dùng
  static Future<void> googleSignOutMethod(BuildContext context) async {
    try {
      await googleSignIn.signOut();
    } catch (e) {
      print("Error while signing out: $e");
    }
  }

  /// Hàm thực hiện đăng nhập bằng Google
  Future<void> googleSignInMethod(BuildContext context) async {
    try {
      // Đăng nhập bằng Google và lấy thông tin đăng nhập của tài khoản
      GoogleSignInAccount? account = await googleSignIn.signIn();
      GoogleSignInAuthentication? googleSignInAuthentication =
          await account?.authentication;

      // Tạo credential
      final AuthCredential credential = GoogleAuthProvider.credential(
          idToken: googleSignInAuthentication?.idToken,
          accessToken: googleSignInAuthentication?.accessToken);

      // Thực hiện đăng nhập Firebase với credential
      UserCredential userCredential = await _auth
          .signInWithCredential(credential)
          .then((value) => _saveData(value, credential));
      // In ra các thông tin của user để kiểm tra
      print("User email: ${credential}");
      print("User email: ${userCredential.user!.email}");

      print("User display name: ${userCredential.user!.displayName}");
      print("User photoURL: ${userCredential.user!.photoURL}");
      // Hiển thị một thông báo thành công (Message là một widget cần được định nghĩa trước đó)
      // Message.show(message: 'Sign in success!', type: MessageType.success);
      // Lưu thông tin User (nếu có)
      // SaveUser(userCredential);
    } catch (e) {
      print("Error while sign in with Google: $e");
      // Hiển thị một thông báo lỗi
      // Message.show(message: 'Sign in failed!', type: MessageType.error);
    }
  }

  _saveData(user, token) async {
    await UserPrefer.setUserName(value: user.user!.displayName);
    await UserPrefer.setEmail(value: user.user!.email);

    await UserPrefer.setImageUser(value: user.user!.photoURL);
    await UserPrefer.setToken(value: user.user!.photoURL);
  }
}
