import 'package:flutter/material.dart';

import 'scopes.dart';

class HomePageChanged extends StatelessWidget {
  const HomePageChanged();

  @override
  Widget build(BuildContext context) {
    AppScope appScope = AppScope.of(context);

    return Hero(
      tag: "mainScaffold",
      child: Scaffold(
        appBar: AppBar(
          leading: BackButton(
            color: Colors.white,
          ),
          title: Text(appScope.authInstance.getUser().displayName),
          actions: <Widget>[
            _logoutButton(context),
          ],
        ),
        body: newBody,
      ),
    );
  }
}

Drawer drawer = Drawer(
  child: ListView(
    children: <Widget>[
      ListTile(
        title: Text("Hello"),
      ),
      ListTile(
        title: Text("World"),
      ),
      ListTile(
        title: Text("!"),
      ),
    ],
  ),
);

IconButton _logoutButton(context) => IconButton(
      icon: Icon(Icons.cancel),
      onPressed: () => Navigator.of(context).pushNamed('/logout'),
    );

Widget newBody = Builder(
  builder: (BuildContext context) => GridView.count(
        crossAxisCount: 2,
        children: <Widget>[
          Hero(
            tag: 'heroTest' + AppScope.of(context).heroState.test.keys.first,
            child: Material(
              color: AppScope.of(context).heroState.test.values.first,
              child: ListTileTheme(
                textColor: AppScope.of(context).heroState.textColor,
                child: ListTile(
                  onTap: () => Navigator.of(context).pop(),
                  title: Text(AppScope.of(context).heroState.test.keys.first),
                  subtitle: Text(
                      "Text Color: 0x${AppScope.of(context).heroState.textColor.value.toRadixString(16)}"),
                ),
              ),
            ),
          )
        ],
      ),
);
