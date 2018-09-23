import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'auth.dart';

class AppScope extends InheritedWidget {
  final authInstance = AuthBloc();
  final userState = UserState();

  AppScope({@required Widget child}) : super(child: child);

  static AppScope of(BuildContext context) =>
      context.inheritFromWidgetOfExactType(AppScope);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => false;
}

class UserState {
  Firestore body = Firestore();
}

//
//class BodyScope extends InheritedWidget {
//  final bodyCallback = _getBody();
//
//  BodyScope({@required Widget child}):super(child: child);
//
//  static Widget _getBody(){
//    return Text("New Body!");
//  }
//
//  static BodyScope of(BuildContext context) => context.inheritFromWidgetOfExactType(BodyScope);
//
//  @override
//  bool updateShouldNotify(InheritedWidget oldWidget) => false;
//}
