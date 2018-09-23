import 'package:flutter/material.dart';

import 'home_page.dart';
import 'home_page_changed.dart';
import 'login_page.dart';
import 'logout_page.dart';
import 'scopes.dart';
import 'splash_screen.dart';

void main() => runApp(() {
      return AppScope(
        child: MyApp(),
      );
    }());

class MyApp extends MaterialApp {
  MyApp()
      : super(
          title: 'Reservation',
          theme: ThemeData.dark().copyWith(
            primaryColor: Colors.amber,
            buttonColor: Colors.tealAccent,
            buttonTheme: ButtonThemeData(
              textTheme: ButtonTextTheme.primary,
            ),
            textTheme: TextTheme(
              button: TextStyle(
                color: Colors.green,
              ),
            ),
          ),
          home: const LoginPage(),
          routes: {
//      '/login' : (context)=>LoginPage(),
            '/splash': (context) => const SplashScreen(),
            '/home': (context) => const HomePage(),
            '/logout': (context) => const LogoutPage(),
            '/home/changed': (context) => const HomePageChanged(),
          },
        );
}
