import 'package:flutter/material.dart';
import 'scopes.dart';
class LoginPage extends StatelessWidget {

  const LoginPage();

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          _googleLoginButton,
          _facebookLoginButton,
          _phoneLoginButton,
          _emailPasswordlessLoginButton,
          _emailAndPasswordLoginButton,
        ],
      ),
    );
  }
}

const _googleLoginButton = _LoginButton(
  onPressed: null,
  child: Text("Google Account"),
);
const _facebookLoginButton = _LoginButton(
  onPressed: null,
  child: Text("Facebook Account"),
);
const _phoneLoginButton = _LoginButton(
  onPressed: null,
  child: Text("Phone Verification"),
);
const _emailPasswordlessLoginButton = _LoginButton(
  onPressed: null,
  child: Text("Email Verification"),
);
const _emailAndPasswordLoginButton = _LoginButton(
  onPressed: null,
  child: Text("Email and Password"),
);


class _LoginButton extends StatelessWidget {
  final Function onPressed;
  final Widget child;
  const _LoginButton({@required this.onPressed, this.child});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      color: Theme.of(context).buttonColor,
      onPressed: onPressed??() async {
        Navigator.of(context).pushNamed('/splash');
        await AuthScope.of(context).authInstance.login();
        Navigator.of(context).pushNamedAndRemoveUntil('/home', (Route<dynamic> route)=>false);
  },
      minWidth: MediaQuery.of(context).size.width*.67,
      child: child??Container(),
    );
  }
}
