import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthBloc {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  static GoogleSignInAccount googleUser;
  static FirebaseUser currentUser;

  Future<FirebaseUser> _loginWithGoogle() async {
    googleUser = await googleSignIn.signIn();

    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    return auth.signInWithGoogle(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
  }

  Future<void> login() async {
    FirebaseUser user = await _loginWithGoogle();
    assert(user.email != null);
    assert(user.displayName != null);
    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);

    currentUser = await auth.currentUser();
    assert(user.uid == currentUser.uid);
  }

  Future<void> logout() async {
    googleUser = await googleSignIn.signOut();
    await auth.signOut();
  }

  FirebaseUser getUser() => currentUser;
}
