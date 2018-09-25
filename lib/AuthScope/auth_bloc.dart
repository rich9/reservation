import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthBloc {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  static GoogleSignInAccount _googleUser;
  static FirebaseUser _currentUser;

  Future<GoogleSignInAuthentication> _loginWithGoogle() async {
    _googleUser = await _googleSignIn.signIn();
    return await _googleUser.authentication;
  }

  Future<FirebaseUser> login() async {
    GoogleSignInAuthentication googleAuth = await _loginWithGoogle();
    return _currentUser = await _auth.signInWithGoogle(
      idToken: googleAuth.idToken,
      accessToken: googleAuth.accessToken,
    );
  }

  Future<void> logout() async {
    _googleUser = await _googleSignIn.signOut();
    await _auth.signOut();
    _currentUser = null;
  }

  FirebaseUser get user => _currentUser;
}
