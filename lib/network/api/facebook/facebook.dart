// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

// Future<UserCredential?> signInWithFacebook() async {
//   try {
//     // Login in facebook
//     final LoginResult loginResult = await FacebookAuth.instance.login();

//     // Get access token
//     final AccessToken accessToken = loginResult.accessToken!;

//     // Create a credential from the access token
//     final OAuthCredential facebookAuthCredential =
//         FacebookAuthProvider.credential(accessToken.token);

//     // Sign in with the credential
//     final UserCredential userCredential = await FirebaseAuth.instance
//         .signInWithCredential(facebookAuthCredential);

//     return userCredential;
//   } on FirebaseAuthException catch (e) {
//     print('FirebaseAuthException: $e');
//     return null;
//   } catch (e) {
//     print('Error: $e');
//     return null;
//   }
// }
