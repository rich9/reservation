import 'package:flutter/material.dart';

import 'body.dart';

class HomePageChanged extends StatelessWidget {
  const HomePageChanged();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(56.0),
        child: AppBar(
//        automaticallyImplyLeading: false,
          leading: BackButton(),
          title: Text("Hello!"),
        ),
      ),
      body: const BodyTwo(),
    );
  }
}
