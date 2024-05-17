import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:logger/logger.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final Logger logger = Logger();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;


  Future<User?> signInWithEmailAndPassword(String email, String password) async {
    try {
      final UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } catch (e) {
      logger.e("Error signing in: $e");
      return null;
    }
  }

   Future<User?> registerUser(String email, String password, String displayName) async {

    try {
      final UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      try {
        await _firestore.collection('users').doc(userCredential.user!.uid).set({
          'uid': userCredential.user!.uid,
          'displayName': displayName,
          'email': email,
        });
      } catch (e) {
        logger.e("Error registering user: $e");
        return null;
      }

      await userCredential.user!.updateDisplayName(displayName);
      return userCredential.user;
    } catch (e) {
      logger.e("Error signing in: $e");
      return null;
    }
  }
}
