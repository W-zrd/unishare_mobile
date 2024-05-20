import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:unishare/app/controller/acara_controller.dart';
import 'package:unishare/app/modules/acara/view/acara_all.dart';
import 'package:unishare/app/modules/acara/view/acara_page.dart';
import 'package:unishare/app/modules/acara/view/kompetisi.dart';
import 'package:unishare/app/modules/acara/view/seminar.dart';
import 'package:unishare/app/modules/acara/view/workshop.dart';
import 'package:unishare/app/widgets/card/description_card.dart';
import 'package:unishare/app/widgets/card/post_card.dart';
import 'package:unishare/app/widgets/card/regulation_card.dart';

import '../mock.dart';

class MockAcaraService extends Mock implements AcaraService {
  @override
  Stream<QuerySnapshot> getAcaras() {
    return super.noSuchMethod(
      Invocation.method(#getAcaras, []),
      returnValue: Stream.value(MockQuerySnapshot()),
      returnValueForMissingStub: Stream.value(MockQuerySnapshot()),
    );
  }

  @override
  Stream<QuerySnapshot> getDocumentsByKategori(String kategori) {
    return super.noSuchMethod(
      Invocation.method(#getDocumentsByKategori, [kategori]),
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
  group('AllAcaraPage test suite', () {
    late MockAcaraService mockAcaraService;
    late MockQuerySnapshot mockSnapshot;
    setupFirebaseAuthMocks();

    setUp(() {
      mockAcaraService = MockAcaraService();
      mockSnapshot = MockQuerySnapshot();
    });

    setUpAll(() async {
      await Firebase.initializeApp();
    });

    testWidgets('Verify acara page can be loaded and rendered correctly',
        (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: AcaraPage()));

      expect(find.byType(ElevatedButton), findsExactly(4));
      expect(find.byType(AllAcaraPage), findsOneWidget);

      if (tester.widgetList(find.byType(PostCard)).isNotEmpty) {
        expect(find.byType(PostCard), findsAny);
      }
    });

    testWidgets(
        'Verify post card on each category can navigates to detail acara, and "Persyaratan" tab on detail acara can be pressed',
        (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: AcaraPage()));

      final List<Map<String, dynamic>> kategori = [
        {'key': 'all-category', 'page': AllAcaraPage},
        {'key': 'kompetisi-category', 'page': KompetisiPage},
        {'key': 'workshop-category', 'page': WorkshopPage},
        {'key': 'seminar-category', 'page': SeminarPage},
      ];

      for (final category in kategori) {
        await tester.tap(find.byKey(Key(category['key'])));
        await tester.pumpAndSettle();
        expect(find.byType(category['page']), findsOneWidget);

        if (tester.widgetList(find.byType(PostCard)).isNotEmpty) {
          await tester.tap(find.byType(PostCard).first);
          await tester.pumpAndSettle();
          expect(find.byType(AllAcaraPage), findsNothing);

          await tester.tap(find.widgetWithText(Tab, "Persyaratan"));
          await tester.pumpAndSettle();
          expect(find.byType(RegulationCard), findsOneWidget);
          expect(find.byType(DescriptionCard), findsNothing);

          await tester.tap(find.byType(IconButton).first);
          await tester.pumpAndSettle();
          expect(find.byType(category['page']), findsOneWidget);
        }
      }
    });

    testWidgets('Displays loading text in Acara All page when data is loading',
        (WidgetTester tester) async {
      when(mockAcaraService.getAcaras())
          .thenAnswer((_) => Stream.value(MockQuerySnapshot()));

      await tester.pumpWidget(
        MaterialApp(
          home: AllAcaraPage(acaraService: mockAcaraService),
        ),
      );

      expect(find.text('Loading...'), findsOneWidget);
    });

    testWidgets('Displays PostCard for each acara item',
        (WidgetTester tester) async {
      final mockDocumentSnapshots = [
        MockQueryDocumentSnapshot({
          'kategori': 'Seminar',
          'judul': 'Seminar 1',
          'startDate': Timestamp.fromDate(DateTime(2023, 1, 1)),
          'endDate': Timestamp.fromDate(DateTime(2023, 1, 31)),
          'lokasi': 'Location 1',
        }),
        MockQueryDocumentSnapshot({
          'kategori': 'Workshop',
          'judul': 'Workshop 1',
          'startDate': Timestamp.fromDate(DateTime(2023, 2, 1)),
          'endDate': Timestamp.fromDate(DateTime(2023, 2, 28)),
          'lokasi': 'Location 2',
        }),
      ];

      mockSnapshot.setDocs(mockDocumentSnapshots);

      when(mockAcaraService.getAcaras())
          .thenAnswer((_) => Stream.value(mockSnapshot));

      await tester.pumpWidget(
        MaterialApp(
          home: AllAcaraPage(acaraService: mockAcaraService),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.byType(PostCard), findsNWidgets(2));
      expect(find.text('Seminar 1'), findsOneWidget);
      expect(find.text('Workshop 1'), findsOneWidget);
    });

    testWidgets('Tapping on PostCard navigates to detail acara page',
        (WidgetTester tester) async {
      final mockDocumentSnapshot = MockQueryDocumentSnapshot({
        'kategori': 'Seminar',
        'judul': 'Seminar 1',
        'startDate': Timestamp.fromDate(DateTime(2023, 1, 1)),
        'endDate': Timestamp.fromDate(DateTime(2023, 1, 31)),
        'lokasi': 'Location 1',
      });

      mockSnapshot.setDocs([mockDocumentSnapshot]);

      when(mockAcaraService.getAcaras())
          .thenAnswer((_) => Stream.value(mockSnapshot));

      await tester.pumpWidget(
        MaterialApp(
          home: AllAcaraPage(acaraService: mockAcaraService),
        ),
      );

      await tester.pumpAndSettle();

      await tester.tap(find.byType(PostCard));
      await tester.pumpAndSettle();

      expect(find.byType(AllAcaraPage), findsNothing);
      // Add assertions for the detail acara page if needed
    });
  });
}
