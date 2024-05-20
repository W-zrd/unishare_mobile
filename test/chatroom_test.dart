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

    testWidgets(
        'Home screen can navigate to KARIR PAGE by tapping navbar icon, and vice versa',
            (WidgetTester tester) async {
          FlutterError.onError = ignoreOverflowErrors;
          await tester.pumpWidget(MaterialApp(home: ChatRoom(
            firebaseAuth: mockFirebaseAuth,
            firebaseFirestore: mockFirebaseFirestore,
          )));

          expect(find.byType(ChatRoom), findsOneWidget);
          expect(find.byType(AppBar), findsOneWidget);
          expect(find.text("Chat Room"), findsOneWidget);

          await tester.tap(find.byType(IconButton).first);
          await tester.pumpAndSettle();
          expect(find.byType(HomeScreen), findsOneWidget);
        });

    testWidgets('_buildUserItem displays user item for non-current user', (WidgetTester tester) async {
      final mockDocument = MockQueryDocumentSnapshot({
        'uid': 'user2',
        'displayName': 'User 2',
      });

      when(mockFirebaseFirestore.collection('users')).thenReturn(mockCollectionReference);
      when(mockCollectionReference.snapshots()).thenAnswer((_) => Stream.value(mockQuerySnapshot));
      when(mockQuerySnapshot.docs).thenAnswer((_) => [mockDocument]);

      print('mockQuerySnapshot.docs: ${mockQuerySnapshot.docs}');
      print('mockDocument: $mockDocument');

      await tester.pumpWidget(
        MaterialApp(
          home: ChatRoom(
            firebaseAuth: mockFirebaseAuth,
            firebaseFirestore: mockFirebaseFirestore,
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.text('User 2'), findsOneWidget);
      expect(find.byType(ListTile), findsOneWidget);
    });

    testWidgets('_buildUserItem does not display user item for current user', (WidgetTester tester) async {
      final mockDocument = MockQueryDocumentSnapshot({
        'uid': 'user1',
        'displayName': 'User 1',
      });

      when(mockFirebaseAuth.currentUser).thenReturn(MockUser());
      when(mockFirebaseFirestore.collection('users')).thenReturn(mockCollectionReference);
      when(mockCollectionReference.snapshots()).thenAnswer((_) => Stream.value(mockQuerySnapshot));
      when(mockQuerySnapshot.docs).thenAnswer((_) => [mockDocument]);

      print('mockQuerySnapshot.docs: ${mockQuerySnapshot.docs}');
      print('mockDocument: $mockDocument');

      await tester.pumpWidget(
        MaterialApp(
          home: ChatRoom(
            firebaseAuth: mockFirebaseAuth,
            firebaseFirestore: mockFirebaseFirestore,
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.text('User 1'), findsNothing);
      expect(find.byType(ListTile), findsNothing);
    });

    testWidgets('Tapping on user item navigates to ChatPage', (WidgetTester tester) async {
      final mockDocument = MockQueryDocumentSnapshot({
        'uid': 'user2',
        'displayName': 'User 2',
      });

      when(mockFirebaseAuth.currentUser).thenReturn(MockUser());
      when(mockFirebaseFirestore.collection('users')).thenReturn(mockCollectionReference);
      when(mockCollectionReference.snapshots()).thenAnswer((_) => Stream.value(mockQuerySnapshot));
      when(mockQuerySnapshot.docs).thenAnswer((_) => [mockDocument]);

      print('mockQuerySnapshot.docs: ${mockQuerySnapshot.docs}');
      print('mockDocument: $mockDocument');

      await tester.pumpWidget(
        MaterialApp(
          home: ChatRoom(
            firebaseAuth: mockFirebaseAuth,
            firebaseFirestore: mockFirebaseFirestore,
          ),
        ),
      );

      await tester.pumpAndSettle();

      await tester.tap(find.byType(ListTile));
      await tester.pumpAndSettle();

      expect(find.byType(ChatPage), findsOneWidget);
      expect(find.text('User 2'), findsOneWidget);
    });
  });
}