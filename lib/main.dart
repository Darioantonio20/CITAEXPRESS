import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/screens/citaexpress.dart';
import 'package:flutter_application_1/src/screens/login.dart';
import 'package:flutter_application_1/src/screens/register.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const CounterScreen(),
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegisterScreen(),
      },
    );
  }
}