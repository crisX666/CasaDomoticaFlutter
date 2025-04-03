import 'package:flutter/material.dart';

class AlertsPage extends StatefulWidget {
  const AlertsPage({Key? key}) : super(key: key);

  @override
  _AlertsPageState createState() => _AlertsPageState();
}

class _AlertsPageState extends State<AlertsPage> {
  // Datos ficticios para 4 sectores
  List<Map<String, dynamic>> sectors = [
    {'sectorName': 'Sector 1', 'obstacle': false},
    {'sectorName': 'Sector 2', 'obstacle': true},
    {'sectorName': 'Sector 3', 'obstacle': false},
    {'sectorName': 'Sector 4', 'obstacle': true},
    {'sectorName': 'Sector 5', 'obstacle': true},
    {'sectorName': 'Sector 6', 'obstacle': true},
    {'sectorName': 'Sector 7', 'obstacle': true},
  ];

  // Función para alternar el estado del obstáculo en un sector
  void toggleObstacle(int index) {
    setState(() {
      sectors[index]['obstacle'] = !sectors[index]['obstacle'];
    });
  }

  @override
  Widget build(BuildContext context) {
    // Calcula el ancho disponible para cada tarjeta (2 columnas)
    final double screenWidth = MediaQuery.of(context).size.width;
    // Considera padding horizontal de 16 a cada lado y 16 de espacio entre tarjetas
    final double itemWidth = (screenWidth - 16 * 3) / 2;
    // Fija una altura para cada tarjeta, por ejemplo 1.2 veces el ancho
    final double itemHeight = itemWidth * 1.2;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Estado de Sensores'),
        backgroundColor: const Color.fromARGB(255, 68, 138, 255),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Wrap(
            spacing: 16.0,
            runSpacing: 16.0,
            children: List.generate(sectors.length, (index) {
              final sector = sectors[index];
              final String sectorName = sector['sectorName'];
              final bool obstacle = sector['obstacle'];

              return Container(
                width: itemWidth,
                height: itemHeight,
                child: Card(
                  elevation: 4.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Icon(
                              obstacle ? Icons.warning : Icons.check_circle,
                              size: 48,
                              color: obstacle ? Colors.red : Colors.green,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              sectorName,
                              style: const TextStyle(
                                fontSize: 18, 
                                fontWeight: FontWeight.bold
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              obstacle
                                  ? 'Obstáculo detectado'
                                  : 'Sin obstáculo',
                              style: const TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                        ElevatedButton(
                          onPressed: () => toggleObstacle(index),
                          child: const Text('Alternar'),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
