import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

class FirebaseConnector {
  // Inicializar Firebase
  static Future<void> initialize() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  // Método para obtener los datos del documento en Firestore
  static Future<Map<String, dynamic>?> getCasaDomoticaData() async {
    try {
      // Referencia al documento
      DocumentSnapshot doc = await FirebaseFirestore.instance
          .collection('CasaDomotica')
          .doc('tsAekrRmFhyMdHcTcMAo')
          .get();

      if (doc.exists) {
        // Retorna los datos del documento en un mapa
        return doc.data() as Map<String, dynamic>;
      } else {
        print('Documento no encontrado');
        return null;
      }
    } catch (e) {
      print('Error al obtener los datos: $e');
      return null;
    }
  }
}
