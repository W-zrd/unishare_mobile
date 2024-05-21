import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileService {
  final FirebaseFirestore _firestore;

  ProfileService({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  Future<User?> getLoggedInUser() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      return user;
    } catch (e) {
      print('Error getting logged in user: $e');
      return null;
    }
  }

  Future<Map<String, dynamic>?> getUserData() async {
    User? user = await getLoggedInUser();
    if (user != null) {
      DocumentSnapshot<Map<String, dynamic>> snapshot =
      await _firestore.collection('users').doc(user.uid).get();
      return snapshot.data();
    }
    return null;
  }

  Future<void> updateUserData(Map<String, dynamic> userData) async {
    try {
      User? user = await getLoggedInUser();
      if (user != null) {
        await _firestore.collection('users').doc(user.uid).update(userData);
      }
    } catch (e) {
      rethrow;
    }
  }
}