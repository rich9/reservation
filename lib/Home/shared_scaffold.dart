import 'package:flutter/material.dart';

import 'body.dart';

class SharedScaffold extends Scaffold {
  final Widget body;
  final AppBar appBar;
  SharedScaffold({@required this.body, @required this.appBar})
      : super(
          appBar: appBar,
          body: Navigator(
            onGenerateRoute: (RouteSettings settings) {
              switch (settings.name) {
                case 'home/body':
                  return MaterialPageRoute(
                    builder: (BuildContext context) => BodyTwo(),
                    settings: settings,
                  );
                default:
                  return MaterialPageRoute(
                    builder: (BuildContext context) => Body(),
                    settings: settings,
                  );
              }
            },
          ),
        );
}
