import 'package:cloud_firestore/cloud_firestore.dart';

Future<Map<String, dynamic>?> fetchDocumentData(String documentId) async {
  try {
    DocumentSnapshot doc = await FirebaseFirestore.instance
        .collection('CasaDomotica')
        .doc(documentId)
        .get();

    if (doc.exists) {
      return doc.data() as Map<String, dynamic>;
    } else {
      print("Documento no encontrado: $documentId");
      return null;
    }
  } catch (e) {
    print("Error al obtener datos: $e");
    return null;
  }
}
