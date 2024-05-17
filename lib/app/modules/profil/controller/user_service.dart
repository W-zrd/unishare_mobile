import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileService {
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
    try {
      User? user = await getLoggedInUser();
      if (user != null) {
        DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
            .instance
            .collection('users')
            .doc(user.uid)
            .get();
        if (snapshot.exists) {
          Map<String, dynamic>? userData = snapshot.data();
          return userData;
        }
        Map<String, dynamic>? userData = null;
        return userData;
      }
      return null;
    } catch (e) {
      print('Error getting user data: $e');
      return null;
    }
  }

  Future<void> updateUserData(Map<String, dynamic> userData) async {
    try {
      User? user = await getLoggedInUser();
      if (user != null) {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .update(userData);
      }
    } catch (e) {
      print('Error updating user data: $e');
    }
  }
}
