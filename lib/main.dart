import 'package:flutter/material.dart';
import 'screens/home_page.dart';
import 'screens/contact_page.dart';
import 'screens/login_content.dart';
import 'screens/about_simple.dart';
import 'screens/main_layout.dart';

void main() {
  runApp(const BookingCareApp());
}

class BookingCareApp extends StatelessWidget {
  const BookingCareApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BookingCare',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const MainLayout(child: HomePage()),
        '/contact': (context) => const MainLayout(child: ContactPage()),
        '/about': (context) => const MainLayout(child: AboutSimple()),
        '/login': (context) => const MainLayout(child: LoginContent()),
      },
    );
  }
}