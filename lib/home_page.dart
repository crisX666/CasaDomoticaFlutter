import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool garageOpen = false;
  bool lightsOn = false;
  bool fanOn = false;
  double temperature = 25.0;
  double humidity = 50.0;

  Future<void> toggleState(String field, bool currentState) async {
    try {
      await FirebaseFirestore.instance
          .collection('CasaDomotica')
          .doc('tsAekrRmFhyMdHcTcMAo')
          .update({field: !currentState});
      setState(() {
        if (field == 'CocheraCasa') garageOpen = !garageOpen;
        if (field == 'LucesCasa') lightsOn = !lightsOn;
        if (field == 'VentiladorCasa') fanOn = !fanOn;
      });
    } catch (e) {
      print("Error al actualizar datos: $e");
    }
  }

  String _lastMusicCommand = "";

  void sendMusicCommand(String command) {
    if (_lastMusicCommand == command.toUpperCase()) {
      command = command.toLowerCase();
    } else {
      command = command.toUpperCase();
    }

    _lastMusicCommand = command;

    FirebaseFirestore.instance
        .collection('CasaDomotica')
        .doc('tsAekrRmFhyMdHcTcMAo')
        .update({'Musica': command});

    print("Comando enviado: $command");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Casa - Detalles'),
        backgroundColor: Color.fromARGB(255, 68, 138, 255),
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection('CasaDomotica')
            .doc('tsAekrRmFhyMdHcTcMAo')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || !snapshot.data!.exists) {
            return const Center(child: Text("No hay datos disponibles"));
          }

          var doc = snapshot.data!;
          garageOpen = doc['CocheraCasa'] ?? false;
          lightsOn = doc['LucesCasa'] ?? false;
          fanOn = doc['VentiladorCasa'] ?? false;
          temperature = double.tryParse(doc['TempCasa'].toString()) ?? 25.0;
          humidity = double.tryParse(doc['HumCasa'].toString()) ?? 50.0;

          return Column(
            children: [
              ControlTile(
                title: 'Garaje',
                state: garageOpen ? "Estado: Abierto" : "Estado: Cerrado",
                onPressed: () => toggleState('CocheraCasa', garageOpen),
              ),
              ControlTile(
                title: 'Luces',
                state: lightsOn ? "Estado: ON" : "Estado: OFF",
                onPressed: () => toggleState('LucesCasa', lightsOn),
              ),
              ControlTile(
                title: 'Ventilador',
                state: fanOn ? "Estado: ON" : "Estado: OFF",
                onPressed: () => toggleState('VentiladorCasa', fanOn),
              ),
              const SizedBox(height: 16),
              const Center(
                child: Text(
                  'Estado Actual',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
                ),
              ),
              Card(
                elevation: 4,
                color: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Temperatura: ${temperature.toStringAsFixed(1)}°C',
                        style: const TextStyle(fontSize: 18, color: Colors.black),
                      ),
                      Text(
                        'Humedad: ${humidity.toStringAsFixed(1)}%',
                        style: const TextStyle(fontSize: 18, color: Colors.black),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class ControlTile extends StatelessWidget {
  final String title;
  final String state;
  final VoidCallback onPressed;

  const ControlTile({required this.title, required this.state, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color(0xFFE0E5F5),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        title: Text(title, style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        subtitle: Text(state, style: TextStyle(color: Color(0xFF2C3357))),
        trailing: ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: Color.fromARGB(255, 68, 138, 255)),
          onPressed: onPressed,
          child: const Text('Alternar', style: TextStyle(color: Colors.black)),
        ),
      ),
    );
  }
}
