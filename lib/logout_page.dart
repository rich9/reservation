import 'package:flutter/material.dart';

import 'scopes.dart';

class LogoutPage extends StatelessWidget {
  const LogoutPage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Logout"),
      ),
      body: Material(
        child: SizedBox.expand(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              RaisedButton(
                onPressed: () async {
                  Navigator.of(context).pushNamed('/splash');
                  await AppScope.of(context).authInstance.logout();
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      '/', (Route<dynamic> route) => false);
                },
                child: Text("Logout!"),
              ),
              RaisedButton(
                splashColor: Colors.green,
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("Change something else"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
