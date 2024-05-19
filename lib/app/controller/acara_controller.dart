import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:unishare/app/models/acara_kemahasiswaan.dart';
import 'package:flutter/material.dart';

class AcaraService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static Future<void> addToFirestore(
      BuildContext context, AcaraKemahasiswaan acaraPost) async {
    try {
      await FirebaseFirestore.instance
          .collection("acara")
          .add(acaraPost.toJson());
      // Show success message or navigate to another screen
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Career post uploaded successfully!')));
      Navigator.pop(context); // Assuming this is in a new screen
    } catch (error) {
      // Show error message to the user
    }
  }

  Stream<QuerySnapshot> getAcaras() {
    return _firestore.collection('acara').snapshots();
  }

  Stream<QuerySnapshot> getDocumentsByKategori(String kategori) {
    return _firestore
        .collection('acara')
        .where("kategori", isEqualTo: kategori)
        .snapshots();
  }
}
