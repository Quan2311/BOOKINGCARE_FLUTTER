import 'package:flutter/material.dart';
import 'screens/home_page.dart';
import 'screens/contact_page.dart';
import 'screens/login_content.dart';
import 'screens/about_simple.dart';
import 'screens/simple_medical_services.dart';
import 'screens/doctors_page.dart';
import 'screens/main_layout.dart';
import 'screens/medical_service_detail_page.dart';

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
      onGenerateRoute: (settings) {
        // Handle parameterized routes
        if (settings.name?.startsWith('/medical-services/') == true) {
          final id = settings.name!.split('/medical-services/')[1];
          return MaterialPageRoute(
            builder: (context) => MainLayout(
              child: MedicalServiceDetailPage(idNameSpecialty: id),
            ),
            settings: settings, // Important: pass settings to preserve route info
          );
        }
        
        // Handle static routes
        return null;
      },
      routes: {
        '/': (context) => const MainLayout(child: HomePage()),
        '/contact': (context) => const MainLayout(child: ContactPage()),
        '/about': (context) => const MainLayout(child: AboutSimple()),
        '/medical-services': (context) => MainLayout(
          child: SimpleMedicalServices(),
        ),
        '/doctors': (context) => const MainLayout(child: DoctorsPage()),
        '/login': (context) => const MainLayout(child: LoginContent()),
      },
    );
  }
}