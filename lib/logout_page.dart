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
        child: Center(
          child:
            RaisedButton(
              onPressed: () async{
                Navigator.of(context).pushNamed('/splash');
                await AuthScope.of(context).authInstance.logout();
                Navigator.of(context).pushNamedAndRemoveUntil('/', (Route<dynamic> route)=>false);
              },
              child: Text("Logout!"),
            )
        ),
      ),
    );
  }
}
