import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ImageService {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String?> pickImageAndUpload() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      File file = File(pickedFile.path);

      try {
        User? currentUser = _auth.currentUser;

        if (currentUser == null) {
          throw FirebaseAuthException(code: 'no-user', message: 'No user is signed in.');
        }

        String userId = currentUser.uid;
        Reference ref = _storage.ref().child('user_profiles/$userId/profile_picture.jpg');

        // Hapus file yang ada terlebih dahulu
        try {
          await ref.delete();
        } catch (e) {
          // Jika file tidak ada, lanjutkan saja
          print('No existing profile picture to delete: $e');
        }

        // Unggah file baru
        UploadTask uploadTask = ref.putFile(file);
        TaskSnapshot taskSnapshot = await uploadTask;

        // Dapatkan URL unduhan dari file yang diunggah
        String downloadUrl = await taskSnapshot.ref.getDownloadURL();
        await _firestore.collection('users').doc(userId).update({
          'profile_picture': downloadUrl,
        });

        return downloadUrl;
      } catch (e) {
        print('Error uploading image: $e');
        return null;
      }
    }

    return null;
  }
}