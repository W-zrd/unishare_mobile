import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:unishare/app/models/acara_kemahasiswaan.dart';

class LatestPostService {
  static Future<List<AcaraKemahasiswaan>> Function() _getLatestPosts = () async {
    final QuerySnapshot<Map<String, dynamic>> querySnapshot =
    await FirebaseFirestore.instance
        .collection('acara')
        .orderBy('timestamp', descending: true)
        .limit(2)
        .get();
    final List<AcaraKemahasiswaan> posts = querySnapshot.docs
        .map((doc) => AcaraKemahasiswaan.fromJson(doc.data()))
        .toList();
    return posts;
  };

  static Future<List<AcaraKemahasiswaan>> getLatestPosts() {
    return _getLatestPosts();
  }

  static set getLatestPostsOverride(
      Future<List<AcaraKemahasiswaan>> Function() override) {
    _getLatestPosts = override;
  }
}