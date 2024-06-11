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

  //update
  static Future<AcaraKemahasiswaan> updateAcara(
      BuildContext context, acaraPost, String id) async {
    await FirebaseFirestore.instance
        .collection('acara')
        .doc(id)
        .update(acaraPost.toJson());
    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Acara post updated successfully!')));
    Navigator.pop(context);
    return acaraPost;
  }

  Stream<QuerySnapshot> getAcaras({bool includeMetadataChanges = false}) {
    return _firestore
        .collection('acara')
        .orderBy('startDate', descending: true) // Urutkan berdasarkan startDate
        .snapshots(includeMetadataChanges: includeMetadataChanges);
  }

  Stream<QuerySnapshot> getDocumentsByKategori(String kategori) {
    return _firestore
        .collection('acara')
        .where("kategori", isEqualTo: kategori)
        .snapshots();
  }

  //delete
  static Future<void> deleteAcara(String id) async {
    await FirebaseFirestore.instance.collection('acara').doc(id).delete();
  }
}
