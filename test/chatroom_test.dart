import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:unishare/app/modules/chat/chatroom.dart';
import 'package:unishare/app/modules/chat/messages.dart';
import 'package:unishare/app/modules/homescreen/home_screen.dart';

import 'mock.dart';
import 'test_helper.dart';

class MockUser extends Mock implements User {
  @override
  String get uid => 'user1';
}

class MockFirebaseAuth extends Mock implements FirebaseAuth {
  @override
  User? get currentUser => MockUser();
}

class MockFirebaseFirestore extends Mock implements FirebaseFirestore {}
class MockCollectionReference extends Mock implements CollectionReference<Map<String, dynamic>> {}
class MockQuerySnapshot extends Mock implements QuerySnapshot<Map<String, dynamic>> {
  @override
  List<QueryDocumentSnapshot<Map<String, dynamic>>> get docs => _docs;

  List<QueryDocumentSnapshot<Map<String, dynamic>>> _docs = [];

  set docs(List<QueryDocumentSnapshot<Map<String, dynamic>>> value) => _docs = value;
}

class MockQueryDocumentSnapshot extends Mock implements QueryDocumentSnapshot<Map<String, dynamic>> {
  final Map<String, dynamic> _data;

  MockQueryDocumentSnapshot(this._data);

  @override
  Map<String, dynamic> data() => _data;

  @override
  String get id => _data['uid'];
}

void main() {
  group('ChatRoom test group', () {
    late MockFirebaseAuth mockFirebaseAuth;
    late MockFirebaseFirestore mockFirebaseFirestore;
    late MockCollectionReference mockCollectionReference;
    late MockQuerySnapshot mockQuerySnapshot;

    setupFirebaseAuthMocks();

    setUpAll(() async {
      await Firebase.initializeApp();
      mockFirebaseAuth = MockFirebaseAuth();
      mockFirebaseFirestore = MockFirebaseFirestore();
      mockCollectionReference = MockCollectionReference();
      mockQuerySnapshot = MockQuerySnapshot();
    });

  });
}