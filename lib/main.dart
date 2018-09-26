import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart' show timeDilation;

import 'AuthScope/auth_scope.dart';
import 'Home/home_page.dart';
import 'Home/home_page_changed.dart';
import 'Login/login_page.dart';
import 'splash_screen.dart';
import 'package:flutter_driver/driver_extension.dart';

void main() {
  timeDilation = 5.0;
  enableFlutterDriverExtension();
  runApp(AuthScope(
    child: MyApp(),
  ));
}

class MyApp extends MaterialApp {
  MyApp()
      : super(
          title: 'Calder Creek Cabins',
          theme: ThemeData.dark().copyWith(
            primaryColor: Colors.green[900],
            accentColor: Colors.brown[500],
            backgroundColor: Colors.green[900],
            textTheme: ThemeData.dark().textTheme.apply(
                  bodyColor: Colors.brown[500],
                ),
          ),
          home: const HomePage(),
          routes: {
            'splash': (_) => const SplashScreen(),
            'login': (_) => const LoginPage(),
            'home/changed': (_) => const HomePageChanged(),
          },
          onGenerateRoute: (RouteSettings settings) => _Router(
                currentRoute: settings.name,
                map: {
                  'home/changedBody': const HomePageChanged(),
                },
              ),
        );
}

PageRouteBuilder _Router({@required currentRoute, Map<String, Widget> map}) {
  return PageRouteBuilder(pageBuilder: (BuildContext context, _, __) {
    Widget child = map[currentRoute];
    if (child == null) {
      return const RuhRo(message: "This route doesn't exist!");
    }
    print(Navigator.of(context).canPop());

    return child;
  });
}

class RuhRo extends StatelessWidget {
  const RuhRo({this.message = "didn't even leave a message..."});
  final String message;

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text("Ruh-ro"),
        ),
        body: ErrorWidget(message),
      );
}
