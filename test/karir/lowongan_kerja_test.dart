import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:unishare/app/controller/karir_controller.dart';
import 'package:unishare/app/modules/karir/lowongan_kerja.dart';

class MockFirebaseFirestore extends Mock implements FirebaseFirestore {}

class MockQueryDocumentSnapshot extends Mock implements QueryDocumentSnapshot<Object?> {
  final Map<String, dynamic> _data;

  MockQueryDocumentSnapshot(this._data);

  @override
  Map<String, dynamic> data() => _data;

  @override
  String get id => _data['id'];
}

class MockQuerySnapshot extends Mock implements QuerySnapshot<Object?> {
  final List<QueryDocumentSnapshot<Object?>> documents;

  MockQuerySnapshot({this.documents = const []});

  @override
  List<QueryDocumentSnapshot<Object?>> get docs => documents;
}

class MockCollectionReference extends Mock implements CollectionReference<Object?> {
  @override
  Stream<QuerySnapshot<Object?>> snapshots({
    bool includeMetadataChanges = false,
  }) {
    final mockDocs = [
      MockQueryDocumentSnapshot({
        'id': '1',
        'posisi': 'Posisi 1',
        'penyelenggara': 'Penyelenggara 1',
        'lokasi': 'Lokasi 1',
        'urlKarir': 'URL 1',
        'img': 'IMG 1',
        'tema': 'Tema 1',
        'kategori': 'Kategori 1',
        'deskripsi': 'Deskripsi 1',
        'startDate': Timestamp.now(),
        'endDate': Timestamp.now(),
        'AnnouncementDate': Timestamp.now()
      }),
      MockQueryDocumentSnapshot({
        'id': '2',
        'posisi': 'Posisi 2',
        'penyelenggara': 'Penyelenggara 2',
        'lokasi': 'Lokasi 2',
        'urlKarir': 'URL 2',
        'img': 'IMG 2',
        'tema': 'Tema 2',
        'kategori': 'Kategori 2',
        'deskripsi': 'Deskripsi 2',
        'startDate': Timestamp.now(),
        'endDate': Timestamp.now(),
        'AnnouncementDate': Timestamp.now()
      }),
    ];

    return Stream.value(MockQuerySnapshot(documents: mockDocs));
  }
}

class MockKarirService extends Mock implements KarirService {
  @override
  Stream<QuerySnapshot<Object?>> getKarirs({bool includeMetadataChanges = false}) {
    final mockDocs = [
      MockQueryDocumentSnapshot({
        'id': '1',
        'posisi': 'Posisi 1',
        'penyelenggara': 'Penyelenggara 1',
        'lokasi': 'Lokasi 1',
        'urlKarir': 'URL 1',
        'img': 'IMG 1',
        'tema': 'Tema 1',
        'kategori': 'Kategori 1',
        'deskripsi': 'Deskripsi 1',
        'startDate': Timestamp.now(),
        'endDate': Timestamp.now(),
        'AnnouncementDate': Timestamp.now()
      }),
      MockQueryDocumentSnapshot({
        'id': '2',
        'posisi': 'Posisi 2',
        'penyelenggara': 'Penyelenggara 2',
        'lokasi': 'Lokasi 2',
        'urlKarir': 'URL 2',
        'img': 'IMG 2',
        'tema': 'Tema 2',
        'kategori': 'Kategori 2',
        'deskripsi': 'Deskripsi 2',
        'startDate': Timestamp.now(),
        'endDate': Timestamp.now(),
        'AnnouncementDate': Timestamp.now()
      }),
    ];

    return Stream.value(MockQuerySnapshot(documents: mockDocs));
  }
}

void main() {
  group('LowonganKerjaPage tests', () {

    setUp(() {
    });

    testWidgets('Displays karir list when data is loaded successfully', (WidgetTester tester) async {
      final karirService = MockKarirService();

      await tester.pumpWidget(
        MaterialApp(home: LowonganKerjaPage(karirService: karirService)),
      );

      await tester.pumpAndSettle();

      expect(find.text("Posisi 1"), findsOneWidget);
      expect(find.byKey(Key('karir_list')), findsOneWidget);
      expect(find.byKey(Key('karir_item_1')), findsOneWidget);
      expect(find.byKey(Key('karir_item_2')), findsOneWidget);
    });
  });
}