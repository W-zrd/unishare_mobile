import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:unishare/app/models/acara_submission_model.dart';

class AcaraSubmissionService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Create
  static Future<void> addToFirestore(
      BuildContext context, AcaraSubmission submission) async {
    try {
      print('Adding submission to Firestore...');
      await FirebaseFirestore.instance
          .collection("acara_submission")
          .add(submission.toMap());
      print('Submission added successfully!');
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Data pendaftaran berhasil dikirim!')));
      Navigator.pop(context);
    } catch (error) {
      print('Error adding submission: $error');
      // Show error message to the user
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Gagal mengirim data pendaftaran!')));
    }
  }

  // Read
  Stream<QuerySnapshot> getSubmissions() {
    return _firestore.collection('acara_submission').snapshots();
  }

  // Read by userID
  Stream<QuerySnapshot> getDocumentsByField(String userID) {
    return _firestore
        .collection('acara_submission')
        .where("userID", isEqualTo: userID)
        .snapshots();
  }
}