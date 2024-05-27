import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:unishare/app/controller/karir_controller.dart';
import 'package:unishare/app/modules/admin/karir/karirpostadmin.dart';
import 'package:unishare/app/modules/admin/karir/makekarirpost.dart';
import 'package:unishare/app/modules/admin/karir/updatekarirpost.dart';

import '../mock.dart';
import '../test_helper.dart';

class MockKarirService extends Mock implements KarirService {
  @override
  Stream<QuerySnapshot> getKarirs({bool includeMetadataChanges = false}) {
    return super.noSuchMethod(
      Invocation.method(#getKarirs, [], {#includeMetadataChanges: includeMetadataChanges}),
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
  group('Admin karir test group', () {
    late MockKarirService mockKarirService;
    late MockQuerySnapshot mockSnapshot;
    setupFirebaseAuthMocks();

    setUpAll(() async {
      await Firebase.initializeApp();
      mockKarirService = MockKarirService();
      mockSnapshot = MockQuerySnapshot();
    });

    testWidgets('Verify the behavior of admin karir FloatingActionButton', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: KarirAdmin()));

      await tester.tap(find.byType(FloatingActionButton));
      await tester.pumpAndSettle();

      expect(find.byType(MakeKarirPost), findsOneWidget);
    });

    testWidgets('Verify the rendering of karir items', (WidgetTester tester) async {
      final mockDocumentSnapshots = [
        MockQueryDocumentSnapshot('doc1', {
          'posisi': 'Software Engineer',
          'penyelenggara': 'UniShare',
          'deskripsi': 'Join our team as a Software Engineer',
          'img': 'assets/img/dazai.jpg',
        }),
        MockQueryDocumentSnapshot('doc2', {
          'posisi': 'Product Manager',
          'penyelenggara': 'UniShare',
          'deskripsi': 'Lead our product development efforts',
          'img': 'assets/img/dazai.jpg',
        }),
      ];

      mockSnapshot.setDocs(mockDocumentSnapshots);

      when(mockKarirService.getKarirs(includeMetadataChanges: false))
          .thenAnswer((_) => Stream.value(mockSnapshot));

      await tester.pumpWidget(
        MaterialApp(
          home: KarirAdmin(karirService: mockKarirService),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.text('Software Engineer'), findsOneWidget);
      expect(find.text('UniShare'), findsNWidgets(2));
      expect(find.text('Product Manager'), findsOneWidget);
    });

    testWidgets('Verify the delete behavior of karir items', (WidgetTester tester) async {
      final mockDocumentSnapshots = [
        MockQueryDocumentSnapshot('doc1', {
          'posisi': 'Software Engineer',
          'penyelenggara': 'UniShare',
          'deskripsi': 'Join our team as a Software Engineer',
          'img': 'assets/img/dazai.jpg',
        }),
      ];

      mockSnapshot.setDocs(mockDocumentSnapshots);

      when(mockKarirService.getKarirs(includeMetadataChanges: false))
          .thenAnswer((_) => Stream.value(mockSnapshot));

      await tester.pumpWidget(
        MaterialApp(
          home: KarirAdmin(karirService: mockKarirService),
        ),
      );

      await tester.pumpAndSettle();

      // Verify the initial state
      expect(find.text('Software Engineer'), findsOneWidget);

      // Tap the delete icon for 'Software Engineer'
      await tester.tap(find.byIcon(Icons.delete).first);
      await tester.pumpAndSettle();

      // Verify the confirmation dialog is shown
      expect(find.byType(AlertDialog), findsOneWidget);
      expect(find.text('Delete'), findsOneWidget);

      // Tap the 'Delete' button in the confirmation dialog
      await tester.tap(find.byKey(Key('delete-button')));
      await tester.pumpAndSettle();

      // Update the mock snapshot to remove the deleted item
      mockSnapshot.setDocs([]);

      // Rebuild the widget tree
      await tester.pumpWidget(
        MaterialApp(
          home: KarirAdmin(karirService: mockKarirService),
        ),
      );

      await tester.pumpAndSettle();

      // Verify that 'Software Engineer' is deleted
      expect(find.text('Software Engineer'), findsNothing);
    });

    testWidgets('Verify the update behavior of karir items', (WidgetTester tester) async {
      final mockDocumentSnapshots = [
        MockQueryDocumentSnapshot('doc1', {
          'posisi': 'Software Engineer',
          'penyelenggara': 'UniShare',
          'deskripsi': 'Join our team as a Software Engineer',
          'img': 'assets/img/dazai.jpg',
          'tema': 'Teknologi',
          'kategori': 'Lowongan Kerja',
          'lokasi': 'Jakarta',
          'urlKarir': 'https://example.com',
          'startDate': Timestamp.now(),
          'endDate': Timestamp.now(),
        }),
      ];

      mockSnapshot.setDocs(mockDocumentSnapshots);

      when(mockKarirService.getKarirs(includeMetadataChanges: false))
          .thenAnswer((_) => Stream.value(mockSnapshot));

      await tester.pumpWidget(
        MaterialApp(
          home: KarirAdmin(karirService: mockKarirService),
        ),
      );

      await tester.pumpAndSettle();

      // Verify that the KarirAdmin screen is visible
      expect(find.byType(KarirAdmin), findsOneWidget);

      // Tap the edit icon for 'Software Engineer'
      await tester.tap(find.byKey(Key("edit-karir")).first);
      await tester.pumpAndSettle();

      // Verify that the UpdateKarirPost screen is visible
      expect(find.byType(UpdateKarirPost), findsOneWidget);

      // Enter updated values in the form fields
      await tester.enterText(find.byKey(Key('posisi-field')), 'Updated Position');
      await tester.enterText(find.byKey(Key('penyelenggara-field')), 'Updated Organizer');
      await tester.enterText(find.byKey(Key('lokasi-field')), 'Updated Location');
      await tester.enterText(find.byKey(Key('url-field')), 'https://updated-example.com');
      await tester.enterText(find.byKey(Key('deskripsi-field')), 'Updated Description');

      // Tap the update button
      await tester.ensureVisible(find.byType(ElevatedButton));
      await tester.tap(find.widgetWithText(ElevatedButton, 'Update'));
      await tester.pumpAndSettle();

      // Verify that the UpdateKarirPost screen is dismissed
      expect(find.byType(UpdateKarirPost), findsOneWidget);
    });

    testWidgets('Verify the create behavior of karir items', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: MakeKarirPost()));

      // Enter valid values in the form fields
      await tester.enterText(find.byType(TextFormField).at(0), 'Software Engineer');
      await tester.enterText(find.byType(TextFormField).at(1), 'UniShare');
      await tester.enterText(find.byType(TextFormField).at(2), 'Jakarta');
      await tester.enterText(find.byType(TextFormField).at(3), 'https://example.com');
      await tester.enterText(find.byType(TextFormField).at(4), 'Join our team as a Software Engineer');

      // Ensure the "Unggah" button is visible
      await tester.ensureVisible(find.widgetWithText(ElevatedButton, 'Unggah'));

      // Tap the "Unggah" button
      await tester.tap(find.widgetWithText(ElevatedButton, 'Unggah'));
      await tester.pumpAndSettle();

      // Verify that the MakeKarirPost screen is dismissed
      expect(find.byType(MakeKarirPost), findsOneWidget);
    });
  });
}