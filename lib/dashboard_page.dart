import 'package:flutter/material.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Inicio',
          style: TextStyle(color: Color.fromARGB(255, 0, 0, 0), fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        backgroundColor: const Color.fromARGB(255, 68, 138, 255), // Azul violeta oscuro
        elevation: 10,
      ),
      backgroundColor: const Color.fromARGB(255, 236, 249, 241), // Fondo lila claro
      body: GridView.count(
        padding: const EdgeInsets.all(16.0),
        crossAxisCount: 2,
        crossAxisSpacing: 16.0,
        mainAxisSpacing: 16.0,
        children: [
          _buildRoomCard(context, 'Vehículo', Icons.car_repair),
          _buildRoomCard(context, 'Casa', Icons.house),
          _buildRoomCard(context, 'Registros', Icons.analytics),
          _buildRoomCard(context, 'Alertas',
              Icons.system_security_update_warning_outlined),
          _buildRoomCard(context, 'Configuración', Icons.settings),
          _buildRoomCard(context, 'Conexión', Icons.cable),
        ],
      ),
    );
  }

  Widget _buildRoomCard(BuildContext context, String title, IconData icon) {
    return GestureDetector(
      onTap: () {
        if (title == 'Casa') {
          Navigator.pushNamed(context, '/home');
        } else if (title == 'Vehículo') {
          Navigator.pushNamed(context, '/vehicle');
        } else if (title == 'Registros') {
          Navigator.pushNamed(context, '/logs');
        } else if (title == 'Alertas') {
          Navigator.pushNamed(context, '/alerts');
        } else if (title == 'Configuración') {
          Navigator.pushNamed(context, '/settings');
        } else if (title == 'Conexión') {
          Navigator.pushNamed(context, '/connection');
        } 
      },
      child: Card(
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        color: const Color.fromARGB(255, 255, 255, 255), // Fondo más claro para las tarjetas
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 48,
                color: const Color.fromARGB(255, 68, 138, 255), // Mismo azul violeta del AppBar
              ),
              const SizedBox(height: 8.0),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 0, 0, 0),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
