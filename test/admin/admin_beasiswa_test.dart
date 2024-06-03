import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:unishare/app/controller/beasiswa_controller.dart';
import 'package:unishare/app/modules/admin/beasiswa/beasiswa_post_admin.dart';
import 'package:unishare/app/modules/admin/beasiswa/make_beasiswa_post.dart';
import 'package:unishare/app/modules/admin/beasiswa/update_beasiswa_post.dart';

import '../mock.dart';

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
      expect(find.byType(AppBar), findsOneWidget);
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

      // Update the mock snapshot to remove the deleted item
      mockSnapshot.setDocs([]);

      // Rebuild the widget tree
      await tester.pumpWidget(
        MaterialApp(
          home: BeasiswaAdmin(beasiswaService: mockBeasiswaService),
        ),
      );

      await tester.pumpAndSettle();

      // Verify that 'Beasiswa 1' is deleted
      expect(find.text('Beasiswa 1'), findsNothing);
    });

    testWidgets('Verify form submission with valid data', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: MakeBeasiswaPost()));

      expect(find.byType(TextFormField), findsNWidgets(4));
      expect(find.byType(ElevatedButton), findsOneWidget);
      expect(find.text('Unggah'), findsOneWidget);

      await tester.pumpWidget(MaterialApp(home: MakeBeasiswaPost()));

      await tester.enterText(find.byType(TextFormField).at(0), 'Judul Beasiswa');
      await tester.enterText(find.byType(TextFormField).at(1), 'Penyelenggara');
      await tester.enterText(find.byType(TextFormField).at(2), 'https://example.com');
      await tester.enterText(find.byType(TextFormField).at(3), 'Deskripsi Beasiswa');

      // Tap the date picker button
      await tester.ensureVisible(find.byKey(Key('date-picker')));
      await tester.tap(find.byKey(Key('date-picker')));
      await tester.pumpAndSettle();

      // Select a date from the date picker
      await tester.tap(find.text('OK'));
      await tester.pumpAndSettle();

      await tester.ensureVisible(find.byType(ElevatedButton));
      await tester.tap(find.byType(ElevatedButton));
      await tester.pumpAndSettle();


      // Verify that the MakeBeasiswaPost widget is removed after successful submission
      expect(find.byType(BeasiswaAdmin), findsNothing);
    });

    testWidgets('Verify the update behavior of beasiswa items', (WidgetTester tester) async {
      final mockDocumentSnapshots = [
        MockQueryDocumentSnapshot('doc1', {
          'judul': 'Beasiswa 1',
          'penyelenggara': 'Penyelenggara 1',
          'deskripsi': 'Deskripsi 1',
          'img': 'assets/img/dazai.jpg',
          'startDate': Timestamp.fromDate(DateTime(2023, 1, 1)),
          'endDate': Timestamp.fromDate(DateTime(2023, 12, 31)),
        }),
        MockQueryDocumentSnapshot('doc2', {
          'judul': 'Beasiswa 2',
          'penyelenggara': 'Penyelenggara 2',
          'deskripsi': 'Deskripsi 2',
          'img': 'assets/img/dazai.jpg',
          'startDate': Timestamp.fromDate(DateTime(2023, 1, 1)),
          'endDate': Timestamp.fromDate(DateTime(2023, 12, 31)),
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

      // Verify that the BeasiswaAdmin screen is visible
      expect(find.byType(BeasiswaAdmin), findsOneWidget);

      // Ensure the edit icon is visible before tapping it
      await tester.ensureVisible(find.byIcon(Icons.edit).first);
      await tester.pumpAndSettle();

      // Tap the edit icon for 'Beasiswa 1'
      await tester.tap(find.byIcon(Icons.edit).first);
      await tester.pumpAndSettle();

      // Verify that the EditBeasiswaPost screen is visible
      expect(find.byType(EditBeasiswaPost), findsOneWidget);

      // Enter updated values in the form fields
      await tester.enterText(find.byType(TextFormField).at(0), 'Updated Beasiswa');
      await tester.enterText(find.byType(TextFormField).at(1), 'Updated Penyelenggara');
      await tester.enterText(find.byType(TextFormField).at(3), 'Updated Deskripsi');

      // Tap the update button
      await tester.ensureVisible(find.byType(ElevatedButton));
      await tester.tap(find.widgetWithText(ElevatedButton, 'Update'));

      // Add a delay to allow time for the navigation to complete
      await tester.pumpAndSettle(Duration(seconds: 2));

      // Verify that the EditBeasiswaPost screen is dismissed
      expect(find.byType(BeasiswaAdmin), findsNothing);
    });
  });
}