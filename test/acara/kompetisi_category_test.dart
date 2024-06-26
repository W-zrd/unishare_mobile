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
import 'package:unishare/app/modules/acara/view/bootcamp.dart';
import 'package:unishare/app/widgets/card/description_card.dart';
import 'package:unishare/app/widgets/card/post_card.dart';
import 'package:unishare/app/widgets/card/regulation_card.dart';

import '../mock.dart';

class MockAcaraService extends Mock implements AcaraService {
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
  group('KompetisiPage test suite', () {
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

    testWidgets(
        'Displays loading text in Kompetisi category when data is loading',
        (WidgetTester tester) async {
      when(mockAcaraService.getDocumentsByKategori('Kompetisi'))
          .thenAnswer((_) => Stream.value(MockQuerySnapshot()));

      await tester.pumpWidget(
        MaterialApp(
          home: KompetisiPage(),
        ),
      );

      expect(find.text('Loading...'), findsOneWidget);
    });

    testWidgets('Calls _buildAcaraList method when KompetisiPage is rendered',
        (WidgetTester tester) async {
      final mockAcaraService = MockAcaraService();
      when(mockAcaraService.getDocumentsByKategori('Kompetisi'))
          .thenAnswer((_) => Stream.value(MockQuerySnapshot()));

      await tester.pumpWidget(
        MaterialApp(
          home: KompetisiPage(acaraService: mockAcaraService),
        ),
      );

      final streamBuilderFinder = find.byWidgetPredicate(
          (widget) => widget is StreamBuilder<QuerySnapshot>);

      expect(streamBuilderFinder, findsOneWidget);
    });

    testWidgets('Displays PostCard for each kompetisi item',
        (WidgetTester tester) async {
      final mockDocumentSnapshots = [
        MockQueryDocumentSnapshot({
          'kategori': 'Kompetisi',
          'judul': 'Kompetisi 1',
          'startDate': Timestamp.fromDate(DateTime(2023, 1, 1)),
          'endDate': Timestamp.fromDate(DateTime(2023, 1, 31)),
          'lokasi': 'Location 1',
        }),
        MockQueryDocumentSnapshot({
          'kategori': 'Kompetisi',
          'judul': 'Kompetisi 2',
          'startDate': Timestamp.fromDate(DateTime(2023, 2, 1)),
          'endDate': Timestamp.fromDate(DateTime(2023, 2, 28)),
          'lokasi': 'Location 2',
        }),
      ];

      final mockSnapshot = MockQuerySnapshot();
      mockSnapshot.setDocs(mockDocumentSnapshots);

      final mockAcaraService = MockAcaraService();
      when(mockAcaraService.getDocumentsByKategori('Kompetisi'))
          .thenAnswer((_) => Stream.value(mockSnapshot));

      await tester.pumpWidget(
        MaterialApp(
          home: KompetisiPage(acaraService: mockAcaraService),
        ),
      );

      await tester.pumpAndSettle();

      final acaraItemFinder = find.byWidgetPredicate((widget) =>
          widget is PostCard &&
          (widget.title == 'Kompetisi 1' || widget.title == 'Kompetisi 2'));

      expect(acaraItemFinder, findsNWidgets(2));
    });
  });
}
