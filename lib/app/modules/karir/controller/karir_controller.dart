import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:unishare/app/modules/karir/models/karir.dart';

class KarirController {
  final CollectionReference karirCollection =
      FirebaseFirestore.instance.collection('karir');

  // Add a new karir document to the Firestore database
  Future<void> addKarir(Karir karir) {
    return karirCollection.add({
      'judulKarir': karir.judulKarir,
      'deskripsiKarir': karir.deskripsiKarir,
      'startDate': karir.startDate,
      'endDate': karir.endDate,
      'thumbnailAsset': karir.thumbnailAsset,
      'salary': karir.salary,
      'minimumWorkExperience': karir.minimumWorkExperience,
      'requirements': karir.requirements,
    });
  }

  // Get all karir documents from the Firestore database
  Stream<QuerySnapshot> getKarirList() {
    return karirCollection.snapshots();
  }

  // Update a karir document in the Firestore database
  Future<void> updateKarir(String karirId, Karir karir) {
    return karirCollection.doc(karirId).update({
      'judulKarir': karir.judulKarir,
      'deskripsiKarir': karir.deskripsiKarir,
      'startDate': karir.startDate,
      'endDate': karir.endDate,
      'thumbnailAsset': karir.thumbnailAsset,
      'salary': karir.salary,
      'minimumWorkExperience': karir.minimumWorkExperience,
      'requirements': karir.requirements,
    });
  }

  // Delete a karir document from the Firestore database
  Future<void> deleteKarir(String karirId) {
    return karirCollection.doc(karirId).delete();
  }
}
