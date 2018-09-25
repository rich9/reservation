import 'package:flutter/material.dart';

import 'body.dart';

class HomePage extends StatelessWidget {
  const HomePage({this.animateLeading = true});
  final animateLeading;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(56.0),
        child: AppBar(
//        automaticallyImplyLeading: false,
          leading: Icon(Icons.menu),
          title: Text("Hello!"),
        ),
      ),
      body: const Body(),
    );
  }
}
