import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'auth.dart';

class AppScope extends InheritedWidget {
  final authInstance = AuthBloc();
  final userState = UserState();
  final heroState = HeroState();

  AppScope({@required Widget child}) : super(child: child);

  static AppScope of(BuildContext context) =>
      context.inheritFromWidgetOfExactType(AppScope);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;
}

class UserState {
  Firestore body = Firestore();
}

class HeroState {
  Map<String, Color> test = {"first": Color(0)};
  Color textColor;

  setTest(Map<String, Color> value) {
    this.test = value;
    Color color = value.values.first;
    this.textColor =
        ((color.red / 255) + (2 * (color.green / 255)) + (color.blue / 255)) < 2
            ? Colors.white
            : Colors.black;
  }
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
