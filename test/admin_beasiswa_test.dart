import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:unishare/app/controller/beasiswa_controller.dart';
import 'package:unishare/app/modules/admin/beasiswa/beasiswa_post_admin.dart';
import 'package:unishare/app/modules/admin/beasiswa/make_beasiswa_post.dart';

import 'mock.dart';

class MockBeasiswaService extends Mock implements BeasiswaService {
  @override
  Stream<QuerySnapshot> getBeasiswas() {
    return super.noSuchMethod(
      Invocation.method(#getBeasiswas, []),
      returnValue: Stream.value(MockQuerySnapshot()),
      returnValueForMissingStub: Stream.value(MockQuerySnapshot()),
    );
  }
}

class MockQuerySnapshot extends Mock implements QuerySnapshot {
  @override
  List<QueryDocumentSnapshot> get docs => _docs;

  List<QueryDocumentSnapshot> _docs = [];

  void setDocs(List<QueryDocumentSnapshot> docs) {
    _docs = docs;
  }
}

class MockQueryDocumentSnapshot extends Mock implements QueryDocumentSnapshot {
  final String? _id;
  final Map<String, dynamic>? _data;

  MockQueryDocumentSnapshot(this._id, this._data);

  @override
  String get id => _id!;

  @override
  Map<String, dynamic>? data() => _data;

  @override
  bool get exists => _data != null;
}

void main() {
  group('Admin Beasiswa test group', () {
    late MockBeasiswaService mockBeasiswaService;
    late MockQuerySnapshot mockSnapshot;
    setupFirebaseAuthMocks();

    setUpAll(() async {
      mockBeasiswaService = MockBeasiswaService();
      mockSnapshot = MockQuerySnapshot();
      await Firebase.initializeApp();
    });

    testWidgets('Verify the presence of widgets', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: BeasiswaAdmin()));

      expect(find.widgetWithText(AppBar, 'Beasiswa'), findsOneWidget);
      expect(find.byType(Column), findsAny);
      expect(find.byType(FloatingActionButton), findsOneWidget);
    });

    testWidgets('Verify the behavior of FloatingActionButton', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: BeasiswaAdmin()));

      await tester.tap(find.byType(FloatingActionButton));
      await tester.pumpAndSettle();

      expect(find.byType(MakeBeasiswaPost), findsOneWidget);
    });

    testWidgets('Verify the rendering of beasiswa items', (WidgetTester tester) async {
      final mockDocumentSnapshots = [
        MockQueryDocumentSnapshot('doc1', {
          'judul': 'Beasiswa 1',
          'penyelenggara': 'Penyelenggara 1',
          'deskripsi': 'Deskripsi 1',
          'img': 'assets/img/dazai.jpg',
        }),
        MockQueryDocumentSnapshot('doc2', {
          'judul': 'Beasiswa 2',
          'penyelenggara': 'Penyelenggara 2',
          'deskripsi': 'Deskripsi 2',
          'img': 'assets/img/dazai.jpg',
        }),
      ];

      mockSnapshot.setDocs(mockDocumentSnapshots);

      // Use `thenAnswer` to return the Stream from the mocked getBeasiswas() method
      when(mockBeasiswaService.getBeasiswas()).thenAnswer((_) => Stream.value(mockSnapshot));

      await tester.pumpWidget(
        MaterialApp(
          home: BeasiswaAdmin(beasiswaService: mockBeasiswaService),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.text('Beasiswa 1'), findsOneWidget);
      expect(find.text('Penyelenggara 1'), findsOneWidget);
      expect(find.text('Beasiswa 2'), findsOneWidget);
      expect(find.text('Penyelenggara 2'), findsOneWidget);
    });

    testWidgets('Verify the delete behavior of beasiswa items', (WidgetTester tester) async {
      final mockDocumentSnapshots = [
        MockQueryDocumentSnapshot('doc1', {
          'judul': 'Beasiswa 1',
          'penyelenggara': 'Penyelenggara 1',
          'deskripsi': 'Deskripsi 1',
          'img': 'assets/img/dazai.jpg',
        }),
      ];

      mockSnapshot.setDocs(mockDocumentSnapshots);

      when(mockBeasiswaService.getBeasiswas()).thenAnswer((_) => Stream.value(mockSnapshot));

      await tester.pumpWidget(
        MaterialApp(
          home: BeasiswaAdmin(beasiswaService: mockBeasiswaService),
        ),
      );

      await tester.pumpAndSettle();

      // Verify the initial state
      expect(find.text('Beasiswa 1'), findsOneWidget);

      // Tap the delete icon for 'Beasiswa 1'
      await tester.tap(find.byIcon(Icons.delete).first);
      await tester.pumpAndSettle();

      expect(find.byType(AlertDialog), findsOneWidget);
      expect(find.text('Delete'), findsOneWidget);

      // Tap the 'Delete' button in the confirmation dialog
      await tester.tap(find.byKey(Key('delete-button')));
      await tester.pumpAndSettle();

      // Verify that 'Beasiswa 1' is deleted
      expect(find.text('Beasiswa 1'), findsNothing);
    });
  });
}