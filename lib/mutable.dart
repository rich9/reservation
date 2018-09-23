import 'dart:async';

import 'package:flutter/material.dart';

class Mutable extends StatefulWidget {
  Mutable({@required this.child});
  final Widget child;

  @override
  State<StatefulWidget> createState() => _MutableState(child: child);
}

class _MutableState extends State<Mutable> {
  _MutableState({@required this.child});
  Widget child;

  @override
  Widget build(BuildContext context) => child;
}

class InheritedStreamBuilder extends InheritedWidget {
  InheritedStreamBuilder({
    @required Stream<dynamic> stream,
    @required Widget child,
  }) : super(
            child: StreamBuilder(
          stream: stream,
          builder: (context, snapshot) => child,
        ));

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;
}
