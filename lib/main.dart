import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/screens/citaexpress.dart';
import 'package:flutter_application_1/src/screens/login.dart';
import 'package:flutter_application_1/src/screens/register.dart';
import 'package:flutter_application_1/src/screens/register_service_provider.dart';
import 'package:flutter_application_1/src/screens/home.dart';
import 'package:flutter_application_1/src/screens/appointment_details.dart'; 
import 'package:flutter_application_1/src/screens/all_items.dart'; 
import 'package:flutter_application_1/src/screens/select_date_and_time.dart';
import 'package:flutter_application_1/src/screens/payment_screen.dart'; 
import 'package:flutter_application_1/src/screens/message_screen.dart'; 
import 'package:flutter_application_1/src/screens/chat_screen.dart'; 
import 'package:flutter_application_1/src/screens/profile_screen.dart';
import 'package:flutter_application_1/src/screens/notifications_screen.dart';

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
        '/appointment_details': (context) => const AppointmentDetailsScreen(),
        '/all_items': (context) => const AllItemsScreen(),
        '/select_date_and_time': (context) => const SelectDateAndTimeScreen(),
        '/payment': (context) => const PaymentScreen(),
        '/messages_screen': (context) => MessageScreen(),
        '/chat_screen': (context) => const ChatScreen(doctorName: 'nanio',),
        '/profile_screen': (context) => const ProfileScreen(),
        '/notifications_screen': (context) => const NotificationsScreen(),
      },
    );
  }
}
