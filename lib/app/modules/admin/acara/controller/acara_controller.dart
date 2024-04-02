import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:unishare/models/acara_post.dart';
import 'package:flutter/material.dart';

class AcaraService{


  static Future<void> addToFirestore(BuildContext context, AcaraPost acaraPost) async {
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
}