import 'package:flutter/material.dart';

import '../AuthScope/auth_scope.dart';

class LoginPage extends StatelessWidget {
  const LoginPage();

  @override
  Widget build(BuildContext context) {
    print(AuthScope.of(context));
    return Material(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          _googleLoginButton,
          _facebookLoginButton,
          _phoneLoginButton(context),
          _emailPasswordlessLoginButton,
          _emailAndPasswordLoginButton,
          _anonymousLoginButton(context),
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
_phoneLoginButton(context) => _LoginButton(
//      onPressed: () => AuthScope.of(context).auth.testVerifyPhoneNumber(),
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
_anonymousLoginButton(BuildContext context) {
  return _LoginButton(
//    onPressed: () => AuthScope.of(context).auth.testSignInAnonymously(),
    onPressed: null,
    child: Text("Anonymously"),
  );
}

class _LoginButton extends StatelessWidget {
  final Function onPressed;
  final Widget child;
  const _LoginButton({@required this.onPressed, this.child});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      color: Theme.of(context).buttonColor,
      onPressed: () async {
        Navigator.of(context).pushNamed('/splash');
        print(AuthScope.of(context));
        await AuthScope.of(context).auth.login();
        Navigator.of(context)
            .pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
      },
      minWidth: MediaQuery.of(context).size.width * .67,
      child: child ?? Container(),
    );
  }
}
