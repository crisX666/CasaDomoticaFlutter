import 'package:flutter/material.dart';

class LogsPage extends StatelessWidget {
  const LogsPage({super.key});

  // Simulamos que estamos obteniendo datos de la base de datos externa.
  Future<Map<String, List<String>>> _fetchLogs() async {
    await Future.delayed(const Duration(seconds: 2)); // Simulación de retraso
    // Aquí puedes integrar la lógica para conectar con tu base de datos
    return {
      "2025-02-26": ["Registro A", "Registro B"],
      "2025-02-27": ["Registro C"],
      "2025-02-28": ["Registro D", "Registro E", "Registro F"]
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registros'),
        backgroundColor: const Color.fromARGB(255, 68, 138, 255),
      ),
      body: FutureBuilder<Map<String, List<String>>>(
        future: _fetchLogs(), // Llamada para obtener los datos
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No hay registros disponibles'));
          } else {
            Map<String, List<String>> logsByDate = snapshot.data!;
            return ListView(
              padding: const EdgeInsets.all(16.0),
              children: logsByDate.entries.map((entry) {
                String date = entry.key;
                List<String> logs = entry.value;
                return _buildDateSection(date, logs);
              }).toList(),
            );
          }
        },
      ),
    );
  }

  // Método para construir la sección de una fecha específica
  Widget _buildDateSection(String date, List<String> logs) {
    return Card(
      elevation: 4.0,
      margin: const EdgeInsets.only(bottom: 16.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: ExpansionTile(
        initiallyExpanded: true, // Se muestra expandido por defecto
        title: Text(
          date,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        children: logs.map((log) {
          return ListTile(
            title: Text(log),
            leading: const Icon(Icons.history, color: Color.fromARGB(255, 68, 138, 255)),
          );
        }).toList(),
      ),
    );
  }
}
