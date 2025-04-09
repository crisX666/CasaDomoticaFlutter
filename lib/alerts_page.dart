import 'package:flutter/material.dart';

class AlertsPage extends StatefulWidget {
  const AlertsPage({Key? key}) : super(key: key);

  @override
  _AlertsPageState createState() => _AlertsPageState();
}

class _AlertsPageState extends State<AlertsPage> {
  final List<Map<String, String>> sensorData = [
    {'zona': 'Zona 1', 'estado': 'Despejado'},
    {'zona': 'Zona 2', 'estado': 'Obstáculo detectado'},
    {'zona': 'Zona 3', 'estado': 'Despejado'},
    {'zona': 'Zona 4', 'estado': 'Obstáculo detectado'},
    {'zona': 'Zona 5', 'estado': 'Despejado'},
    {'zona': 'Zona 6', 'estado': 'Obstáculo detectado'},
    {'zona': 'Zona 7', 'estado': 'Despejado'},
  ];

  Color _getEstadoColor(String estado) {
    if (estado == 'Despejado') {
      return Colors.green;
    } else {
      return Colors.red;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Estado de Sensores'),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/ZonasCasa.png'),
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text('Zona', style: TextStyle(fontWeight: FontWeight.bold)),
                Text('Estado', style: TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          Expanded(
            flex: 3,
            child: SingleChildScrollView(
              child: Table(
                border: TableBorder.all(color: Colors.grey),
                columnWidths: const {
                  0: FlexColumnWidth(1),
                  1: FlexColumnWidth(2),
                },
                children: sensorData.map((item) {
                  final estado = item['estado']!;
                  return TableRow(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(item['zona']!),
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
              ),
            ),
          ),
        ],
      ),
    );
  }
}
