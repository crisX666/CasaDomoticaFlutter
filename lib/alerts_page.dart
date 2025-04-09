import 'package:flutter/material.dart';
import 'dart:async';
import 'fetch_from_database.dart'; // Make sure this is the correct path

class AlertsPage extends StatefulWidget {
  const AlertsPage({Key? key}) : super(key: key);

  @override
  _AlertsPageState createState() => _AlertsPageState();
}

class _AlertsPageState extends State<AlertsPage> {
  Map<String, dynamic>? sensorRawData;
  Timer? _timer;

  final List<String> zonas = [
    'zona1',
    'zona2',
    'zona3',
    'zona4',
    'zona5',
    'zona6',
    'zona7',
  ];

  Future<void> fetchSensorData() async {
    final data = await fetchDocumentData('prueba');
    if (data != null) {
      setState(() {
        sensorRawData = data;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchSensorData();

    // Optional: auto-refresh every 6 seconds
    _timer = Timer.periodic(
      const Duration(seconds: 6),
          (_) => fetchSensorData(),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  Color _getEstadoColor(String estado) {
    return estado == 'Despejado' ? Colors.green : Colors.red;
  }

  String _parseEstado(String value) {
    return value == "0" ? 'Despejado' : 'Obstáculo detectado';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[50],
      appBar: AppBar(
        title: const Text('Estado de Sensores'),
        backgroundColor: Colors.blueAccent,
      ),
      body: sensorRawData == null
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Image
              Container(
                width: double.infinity,
                height: 250,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/ZonasCasa.png'),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              _buildCard('Zonas y Estados', _buildSensorTable()),
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
            Text(title,
                style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            content,
          ],
        ),
      ),
    );
  }

  Widget _buildSensorTable() {
    return Table(
      border: TableBorder.all(color: Colors.grey),
      columnWidths: const {
        0: FlexColumnWidth(1),
        1: FlexColumnWidth(2),
      },
      children: [
        const TableRow(
          children: [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text('Zona', style: TextStyle(fontWeight: FontWeight.bold)),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text('Estado', style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          ],
        ),
        ...zonas.map((zonaKey) {
          final value = sensorRawData?[zonaKey] ?? '0';
          final estado = _parseEstado(value);
          return TableRow(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(zonaKey.toUpperCase().replaceAll('ZONA', 'Zona ')),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  estado,
                  style: TextStyle(
                    color: _getEstadoColor(estado),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          );
        }).toList(),
      ],
    );
  }
}
