import 'package:flutter/material.dart';

import 'auth_bloc.dart';

class AuthScope extends InheritedWidget {
  final AuthBloc auth = AuthBloc();

  AuthScope({@required Widget child}) : super(child: child);

  static AuthScope of(BuildContext context) =>
      context.inheritFromWidgetOfExactType(AuthScope);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;
}
