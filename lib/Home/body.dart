import 'package:flutter/material.dart';

class Body extends StatelessWidget {
  const Body();
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Text("Hello from the OG Body"),
        Hero(
          tag: 'buttonHero',
          child: RaisedButton(
            onPressed: () =>
                Navigator.of(context).pushNamed('home/changedBody'),
            child: Text("go to new Body!"),
          ),
        ),
      ],
    );
  }
}

class BodyTwo extends StatelessWidget {
  const BodyTwo();
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Text("Hello from the Changed Home Page"),
        Hero(
          tag: 'buttonHero',
          child: RaisedButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text("go back to OG Body!"),
          ),
        ),
      ],
    );
  }
}
