import 'dart:async';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
class LoginPage extends StatefulWidget {
  @override
  createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static final GoogleSignIn _googleSignIn = GoogleSignIn();

  static GoogleSignInAccount _googleUser;

  static Future<void> _login(snapshot) async{
    print(snapshot);
    _googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth = await _googleUser.authentication;
    final FirebaseUser user = await _auth.signInWithGoogle(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    assert(user.email != null);
    assert(user.displayName != null);
    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);

    final FirebaseUser currentUser = await _auth.currentUser();
    assert(user.uid == currentUser.uid);
    print(_auth.currentUser());
  }

  Future<void> _logout(snapshot) async{
    _googleUser = await _googleSignIn.signOut();
    await _auth.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _auth.onAuthStateChanged,
      builder: (BuildContext context, AsyncSnapshot<FirebaseUser> snapshot){
        return Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("Hello ${_googleUser?.displayName??"please login"}"),
              RaisedButton(
                onPressed: () => _login(snapshot),
                child: Text("login"),
              ),
              RaisedButton(
                onPressed: () => _logout(snapshot),
                child: Text("logout"),
              ),
            ],
          ),
        );
      },
    );
  }
}