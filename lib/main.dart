import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'auth_wrapper.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'login_page.dart';
import 'dashboard_page.dart';
import 'control_page.dart';
import 'home_page.dart';
import 'car_page.dart';
import 'settings_page.dart';
import 'logs_page.dart';
import 'alerts_page.dart';
import 'register_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

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
      home: const AuthWrapper(), // Manejamos la autenticación globalmente
      onGenerateRoute: (settings) {
        // Verifica la autenticación antes de permitir acceso
        User? user = FirebaseAuth.instance.currentUser;

        if (user == null && settings.name != '/login' && settings.name != '/register') {
          // si no esta autenticado, se redirige al login
          return MaterialPageRoute(builder: (context) => const LoginPage());
        }

        //rutas protegidas
        switch (settings.name) {
          case '/dashboard':
            return MaterialPageRoute(builder: (context) => const DashboardPage());
          case '/control':
            return MaterialPageRoute(builder: (context) => const ControlPage());
          case '/home':
            return MaterialPageRoute(builder: (context) => const HomePage());
          case '/vehicle':
            return MaterialPageRoute(builder: (context) => const CarPage());
          case '/settings':
            return MaterialPageRoute(builder: (context) => const SettingsPage());
          case '/logs':
            return MaterialPageRoute(builder: (context) => const LogsPage());
          case '/alerts':
            return MaterialPageRoute(builder: (context) => const AlertsPage());
          case '/register':
            return MaterialPageRoute(builder: (context) => const RegisterPage());
          case '/login':
          default:
            return MaterialPageRoute(builder: (context) => const LoginPage());
        }
      },
    );
  }
}
