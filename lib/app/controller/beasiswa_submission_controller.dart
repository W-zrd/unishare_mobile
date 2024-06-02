import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:unishare/app/models/beasiswa_submission_model.dart';

class BeasiswaSubmissionService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //create
  static Future<void> addToFirestore(
      BuildContext context, BeasiswaSubmission submission) async {
    try {
      print('Adding submission to Firestore...');
      await FirebaseFirestore.instance
          .collection("beasiswa_submission")
          .add(submission.toMap());
      print('Submission added successfully!');
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Data pendaftaran berhasil dikirim!')));
      Navigator.pop(context);
    } catch (error) {
      print('Error adding submission: $error');
      // Show error message to the user
    }
  }

  //read
  Stream<QuerySnapshot> getSubmissions() {
    return _firestore.collection('beasiswa_submission').snapshots();
  }

  //read by userid
  Stream<QuerySnapshot> getDocumentsByField(String userid) {
    return _firestore
        .collection('beasiswa_submission')
        .where("userID", isEqualTo: userid)
        .snapshots();
  }
}
