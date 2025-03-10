import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:async'; //para actualizar los datos cada cierto tiempo

class CarPage extends StatefulWidget {
  const CarPage({super.key});

  @override
  State<CarPage> createState() => _CarPageState();
}

class _CarPageState extends State<CarPage> {
  Map<String, dynamic>? carData;
  Timer? _timer;

  Future<void> fetchCarData() async {
    try {
      DocumentSnapshot doc = await FirebaseFirestore.instance //Colección y documento que contiene los datos
          .collection('CasaDomotica')
          .doc('tsAekrRmFhyMdHcTcMAo')
          .get();
      if (doc.exists) {
        setState(() {
          carData = doc.data() as Map<String, dynamic>;
        });
      } else {
        print("Documento no encontrado");  //ELIMINAR EN PRODUCCIÓN, PARA TESTEO
      }
    } catch (e) {
      print("Error al obtener datos: $e");
    }
  }

  @override
  void initState() {
    super.initState();
    fetchCarData();

    _timer = Timer.periodic(const Duration(minutes: 1), (timer) { //timer de 1 minuto para actualizar los datos
      fetchCarData();
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[50],
      appBar: AppBar(
        title: const Text('Detalles del Auto'),
        backgroundColor: Colors.blueAccent,
      ),
      body: carData == null
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              _buildCard('Estado Actual', _buildDataTable()),
              const SizedBox(height: 20),
              _buildCard('Tareas Completadas', _buildCompletedTasks()),
              const SizedBox(height: 20),
              _buildOptionsMenu(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCard(String title, Widget content) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            content,
          ],
        ),
      ),
    );
  }

  Widget _buildDataTable() {
    return DataTable(
      columns: const [
        DataColumn(label: Text('Parámetro', style: TextStyle(fontWeight: FontWeight.bold))),
        DataColumn(label: Text('Valor', style: TextStyle(fontWeight: FontWeight.bold))),
      ],
      rows: [
        _buildDataRow('Vehículo', carData!['NombreCarro'] ?? 'Sin Datos'),
        _buildDataRow('Temperatura', '${carData!['TempCarro'] ?? 'Sin Datos'}°C'),
        _buildDataRow('Batería', '${carData!['BateriaCarro'] ?? 'Sin Datos'}%'),
        _buildDataRow('Uptime', '${carData!['UptimeCarro'] ?? 'Sin Datos'} h'),
        _buildDataRow('Distancia Recorrida', '${carData!['DistRecorridaCarro'] ?? 'Sin Datos'} m'),
      ],
    );
  }

  DataRow _buildDataRow(String label, String value) {
    return DataRow(cells: [
      DataCell(Text(label)),
      DataCell(Text(value)),
    ]);
  }

  Widget _buildCompletedTasks() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        _TaskItem(task: 'Revisión de motor'),
        _TaskItem(task: 'Chequeo de batería'),
        _TaskItem(task: 'Calibración de sensores'),
        _TaskItem(task: 'Actualización de software'),
        _TaskItem(task: 'Inspección de neumáticos'),
      ],
    );
  }

  Widget _buildOptionsMenu() {
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      alignment: WrapAlignment.center,
      children: [
        _carPageOption('Actualizar datos', Icons.update),
        _carPageOption('Realizar recorrido', Icons.directions_car),
        _carPageOption('Cancelar recorrido', Icons.cancel),
        _carPageOption('Control Manual', Icons.settings_remote),
      ],
    );
  }

  Widget _carPageOption(String title, IconData icon) {
    return GestureDetector(
      onTap: () {
        if (title == 'Actualizar datos') {
          fetchCarData();
        }
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Icon(icon, size: 48, color: Colors.blueAccent),
              const SizedBox(height: 8.0),
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TaskItem extends StatelessWidget {
  final String task;
  const _TaskItem({required this.task});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          const Icon(Icons.check_circle, color: Colors.blueAccent, size: 20),
          const SizedBox(width: 8),
          Text(task, style: const TextStyle(fontSize: 16)),
        ],
      ),
    );
  }
}
