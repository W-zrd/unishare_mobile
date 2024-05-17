import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:unishare/app/models/karirmodel.dart';

class KarirService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //create
  static Future<void> addToFirestore(
      BuildContext context, KarirPost acaraPost) async {
    try {
      await FirebaseFirestore.instance
          .collection("karir")
          .add(acaraPost.toMap());
      // Show success message or navigate to another screen
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Career post uploaded successfully!')));
      Navigator.pop(context); // Assuming this is in a new screen
    } catch (error) {
      // Show error message to the user
    }
  }

  //read
  Stream<QuerySnapshot> getKarirs() {
    return _firestore.collection('karir').snapshots();
  }

  //read by id
  Future<DocumentSnapshot> getKarirByID(String id) {
    return _firestore.collection('karir').doc(id).get();
  }

  //update
  static Future<KarirPost> updateKarir(
      BuildContext context, karirPost, String id) async {
    await FirebaseFirestore.instance
        .collection('karir')
        .doc(id)
        .update(karirPost.toMap());
    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Career post updated successfully!')));
    Navigator.pop(context); // Assuming this is in a new screen
    return karirPost;
  }

  //delete
  static Future<void> deleteKompetisi(String id) async {
    await FirebaseFirestore.instance.collection('karir').doc(id).delete();
  }
}
