import 'package:flutter/material.dart';
import 'auth.dart';
class AuthScope extends InheritedWidget{

  final authInstance = AuthBloc();

  AuthScope({@required Widget child}):super(child: child);

  static AuthScope of(BuildContext context) => context.inheritFromWidgetOfExactType(AuthScope);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => false;
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