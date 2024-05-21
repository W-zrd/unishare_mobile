import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:unishare/app/controller/beasiswa_controller.dart';
import 'package:unishare/app/modules/beasiswa/beasiswa_screen.dart';
import 'package:unishare/app/modules/homescreen/home_screen.dart';

import '../mock.dart';
import '../test_helper.dart';

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
  final Map<String, dynamic>? _data;

  MockQueryDocumentSnapshot(this._data);

  @override
  Map<String, dynamic>? data() => _data;

  @override
  bool get exists => _data != null;
}

void main() {
  setupFirebaseAuthMocks();

  setUpAll(() async {
    await Firebase.initializeApp();
  });
  group('BeasiswaScreen', () {
    late MockBeasiswaService mockBeasiswaService;
    late MockQuerySnapshot mockSnapshot;

    setUp(() {
      mockBeasiswaService = MockBeasiswaService();
      mockSnapshot = MockQuerySnapshot();
    });

    testWidgets('Displays loading text when data is loading',
            (WidgetTester tester) async {
              FlutterError.onError = ignoreOverflowErrors;
          when(mockBeasiswaService.getBeasiswas())
              .thenAnswer((_) => Stream.value(MockQuerySnapshot()));

          await tester.pumpWidget(
            MaterialApp(
              home: BeasiswaScreen(beasiswaService: mockBeasiswaService),
            ),
          );

          expect(find.text('Loading...'), findsOneWidget);
        });

    testWidgets('Displays beasiswa items when data is loaded',
            (WidgetTester tester) async {
          final mockDocumentSnapshots = [
            MockQueryDocumentSnapshot({
              'jenis': 'Beasiswa 1',
              'judul': 'Judul Beasiswa 1',
              'penyelenggara': 'Penyelenggara 1',
            }),
            MockQueryDocumentSnapshot({
              'jenis': 'Beasiswa 2',
              'judul': 'Judul Beasiswa 2',
              'penyelenggara': 'Penyelenggara 2',
            }),
          ];

          mockSnapshot.setDocs(mockDocumentSnapshots);

          when(mockBeasiswaService.getBeasiswas())
              .thenAnswer((_) => Stream.value(mockSnapshot));

          await tester.pumpWidget(
            MaterialApp(
              home: BeasiswaScreen(beasiswaService: mockBeasiswaService),
            ),
          );

          await tester.pumpAndSettle();

          expect(find.text('Beasiswa 1'), findsOneWidget);
          expect(find.text('Judul Beasiswa 1'), findsOneWidget);
          expect(find.text('Beasiswa 2'), findsOneWidget);
          expect(find.text('Judul Beasiswa 2'), findsOneWidget);
        });

    testWidgets('Navigates back to HomeScreen when the back button is pressed',
            (WidgetTester tester) async {
              FlutterError.onError = ignoreOverflowErrors;
          await tester.pumpWidget(
            MaterialApp(
              home: BeasiswaScreen(),
            ),
          );

          await tester.tap(find.byIcon(Icons.arrow_back));
          await tester.pumpAndSettle();

          expect(find.byType(BeasiswaScreen), findsNothing);
          expect(find.byType(HomeScreen), findsOneWidget);
        });
  });
}