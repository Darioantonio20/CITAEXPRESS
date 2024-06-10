import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/screens/citaexpress.dart';
import 'package:flutter_application_1/src/screens/login.dart';
import 'package:flutter_application_1/src/screens/register.dart';
import 'package:flutter_application_1/src/screens/register_service_provider.dart';
import 'package:flutter_application_1/src/screens/home.dart'; 

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
        '/registerServiceProvider': (context) => const RegisterServiceProvider(), 
        '/home': (context) => const HomeScreen(), 
      },
    );
  }
}
