import 'package:flutter/material.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Inicio',
          style: TextStyle(
            color: Color.fromARGB(255, 0, 0, 0),
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        backgroundColor: const Color.fromARGB(255, 68, 138, 255),
        elevation: 10,
      ),
      backgroundColor: const Color.fromARGB(255, 236, 249, 241),
      body: LayoutBuilder(
        builder: (context, constraints) {
          double width = constraints.maxWidth;
          int crossAxisCount = 2;

          if (width > 1200) {
            crossAxisCount = 4;
          } else if (width > 800) {
            crossAxisCount = 3;
          } else if (width > 600) {
            crossAxisCount = 2;
          } else {
            crossAxisCount = 2;
          }

          double itemWidth = (width - (crossAxisCount - 1) * 16) / crossAxisCount;
          double itemHeight = itemWidth * 0.9;
          double aspectRatio = itemWidth / itemHeight;

          final items = [
            {'title': 'Vehículo', 'icon': Icons.car_repair},
            {'title': 'Casa', 'icon': Icons.house},
            {'title': 'Registros', 'icon': Icons.analytics},
            {'title': 'Alertas', 'icon': Icons.system_security_update_warning_outlined},
            {'title': 'Configuración', 'icon': Icons.settings},
            {'title': 'Conexión', 'icon': Icons.cable},
          ];

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: GridView.builder(
              itemCount: items.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                crossAxisSpacing: 16.0,
                mainAxisSpacing: 16.0,
                childAspectRatio: aspectRatio,
              ),
              itemBuilder: (context, index) {
                return _buildRoomCard(
                  context,
                  items[index]['title'] as String,
                  items[index]['icon'] as IconData,
                );
              },
            ),
          );
        },
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
        color: const Color.fromARGB(255, 255, 255, 255),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 48,
                color: const Color.fromARGB(255, 68, 138, 255),
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
