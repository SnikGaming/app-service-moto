
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  // Create a GoogleSignIn instance to handle user authentication.
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  // Create a FirebaseAuth instance to communicate with Firebase Authentication.
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // A boolean variable to indicate whether the sign-in process is currently in progress.
  bool _isSigningIn = false;

  // The build method for the sign-in screen.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign In'),
      ),
      body: Center(
        child: _isSigningIn
            ? CircularProgressIndicator()
            : ElevatedButton(
                child: Text('Sign in with Google'),
                onPressed: () async {
                  // Set the _isSigningIn variable to true to start the sign-in process.
                  setState(() {
                    _isSigningIn = true;
                  });

                  try {
                    // Attempt to sign in with Google.
                    final GoogleSignInAccount? googleAccount =
                        await _googleSignIn.signIn();

                    if (googleAccount == null) {
                      // If the user cancelled the sign-in process, set the _isSigningIn variable to false and return.
                      setState(() {
                        _isSigningIn = false;
                      });
                      return;
                    }

                    // Authenticate with Firebase using the Google credential.
                    final GoogleSignInAuthentication googleAuth =
                        await googleAccount.authentication;
                    final AuthCredential credential =
                        GoogleAuthProvider.credential(
                      accessToken: googleAuth.accessToken,
                      idToken: googleAuth.idToken,
                    );
                    final UserCredential userCredential =
                        await _auth.signInWithCredential(credential);

                    // If sign-in was successful, navigate to the home screen.
                    final User? user = userCredential.user;
                    if (user != null) {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => HomeScreen()),
                      );
                    }

                    // Set the _isSigningIn variable to false to indicate that the sign-in process has ended.
                    setState(() {
                      _isSigningIn = false;
                    });
                  } catch (e) {
                    // If an error occurred, log the error message and set the _isSigningIn variable to false.
                    print(e);
                    setState(() {
                      _isSigningIn = false;
                    });
                  }
                },
              ),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  // The build method for the home screen.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Center(
        child: Text('Welcome!'),
      ),
    );
  }
}
