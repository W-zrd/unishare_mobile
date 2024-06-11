import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:unishare/app/models/beasiswa_model.dart';

class BeasiswaService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //create
  static Future<void> addToFirestore(
      BuildContext context, BeasiswaPost acaraPost) async {
    try {
      await FirebaseFirestore.instance
          .collection("beasiswa")
          .add(acaraPost.toMap());
      // Show success message or navigate to another screen
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Scholarship post uploaded successfully!')));
      Navigator.pop(context); // Assuming this is in a new screen
    } catch (error) {
      // Show error message to the user
    }
  }

  //read
  Stream<QuerySnapshot> getBeasiswas({bool includeMetadataChanges = false}) {
    try {
      return _firestore
          .collection('beasiswa')
          .orderBy('startDate',
              descending: true) // Urutkan berdasarkan startDate
          .snapshots(includeMetadataChanges: includeMetadataChanges);
    } catch (e) {
      // Handle any errors that occur while fetching the data
      print('Error fetching beasiswa data: $e');
      return const Stream.empty(); // Return an empty stream to avoid null
    }
  }

  //update
  static Future<BeasiswaPost> updateBeasiswa(
      BuildContext context, beasiswaPost, String id) async {
    print('Updating beasiswa with ID: $id');
    await FirebaseFirestore.instance
        .collection('beasiswa')
        .doc(id)
        .update(beasiswaPost.toMap());
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Scholarship post updated successfully!')));
    Navigator.pop(context);
    return beasiswaPost;
  }

  //delete
  static Future<void> deleteBeasiswa(String id) async {
    await FirebaseFirestore.instance.collection('beasiswa').doc(id).delete();
  }
}
