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

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      DocumentSnapshot doc = await FirebaseFirestore.instance
          .collection('CasaDomotica')
          .doc('tsAekrRmFhyMdHcTcMAo')
          .get();
      if (doc.exists) {
        setState(() {
          garageOpen = doc['CocheraCasa'] ?? false;
          lightsOn = doc['LucesCasa'] ?? false;
          fanOn = doc['VentiladorCasa'] ?? false;
          temperature = (doc['TempCasa'] ?? 25).toDouble();
          humidity = (doc['HumCasa'] ?? 50).toDouble();
        });
      }
    } catch (e) {
      print("Error al obtener datos: $e");
    }
  }

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

  void sendMusicCommand(String command) {
    FirebaseFirestore.instance
        .collection('CasaDomotica')
        .doc('tsAekrRmFhyMdHcTcMAo')
        .update({'Musica': command});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Casa - Detalles'),
        backgroundColor: Color(0xFF3E4A89),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
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
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF3E4A89)),
                    ),
                  ),
                  Card(
                    elevation: 4,
                    color: Color(0xFFE0E5F5),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Temperatura: ${temperature.toStringAsFixed(1)}°C',
                            style: const TextStyle(fontSize: 18, color: Color(0xFF3E4A89)),
                          ),
                          Text(
                            'Humedad: ${humidity.toStringAsFixed(1)}%',
                            style: const TextStyle(fontSize: 18, color: Color(0xFF3E4A89)),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16.0),
            color: Color(0xFFD4D9F0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF3E4A89)),
                  onPressed: () => sendMusicCommand("B"),
                  child: const Icon(Icons.fast_rewind, color: Colors.white),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF3E4A89)),
                  onPressed: () => sendMusicCommand("P"),
                  child: const Icon(Icons.play_arrow, color: Colors.white),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF3E4A89)),
                  onPressed: () => sendMusicCommand("F"),
                  child: const Icon(Icons.fast_forward, color: Colors.white),
                ),
              ],
            ),
          ),
        ],
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
        title: Text(title, style: TextStyle(color: Color(0xFF3E4A89), fontWeight: FontWeight.bold)),
        subtitle: Text(state, style: TextStyle(color: Color(0xFF3E4A89))),
        trailing: ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF3E4A89)),
          onPressed: onPressed,
          child: const Text('Alternar', style: TextStyle(color: Colors.white)),
        ),
      ),
    );
  }
}