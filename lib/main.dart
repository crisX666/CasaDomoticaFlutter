import 'package:flutter/material.dart';
import 'login_page.dart';
import 'dashboard_page.dart';
import 'control_page.dart';
import 'home_page.dart';
import 'car_page.dart';
import 'settings_page.dart';
import 'logs_page.dart';
import 'register_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';  // Asegúrate de que esta importación esté presente
import 'package:cloud_firestore/cloud_firestore.dart';  // Para usar Firestore


void main() async {
  //inicializar Flutter antes de hacer cualquier cosa
  WidgetsFlutterBinding.ensureInitialized();
  //inicializa Firebase con la configuración correspondiente
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform, // Usa la configuración generada
  );
  //despues de la inicialización ejecutar la app
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Control de casa domótica',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginPage(),
        '/dashboard': (context) => const DashboardPage(),
        '/control': (context) => const ControlPage(),
        '/home': (context) => const HomePage(),
        '/vehicle': (context) => const CarPage(),
        '/settings': (context) => const SettingsPage(),
        '/logs': (context) => const LogsPage(),
        '/register': (context) => const RegisterPage(),
      },
    );
  }
}
