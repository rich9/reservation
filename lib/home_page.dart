import 'package:flutter/material.dart';
import 'scopes.dart';

class HomePage extends StatelessWidget {
  const HomePage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(AuthScope.of(context).authInstance.getUser().displayName),
          actions: <Widget>[
            _logoutButton(context),
          ],
        ),
        body: Material(child: Center(child: Text("Hello!"))),
    );
  }
}

IconButton _logoutButton(context) => IconButton(
  icon: Icon(Icons.cancel),
  onPressed: () => Navigator.of(context).pushNamed('/logout'),
);
