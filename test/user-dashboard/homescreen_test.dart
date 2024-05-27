import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:mockito/mockito.dart';
import 'package:unishare/app/controller/beasiswa_controller.dart';
import 'package:unishare/app/controller/karir_controller.dart';
import 'package:unishare/app/modules/acara/view/acara_page.dart';
import 'package:unishare/app/modules/beasiswa/beasiswa_screen.dart';
import 'package:unishare/app/modules/dashboard/dashboard_screen.dart';
import 'package:unishare/app/modules/dashboard/homepage_cardd.dart';
import 'package:unishare/app/modules/homescreen/home_screen.dart';
import 'package:unishare/app/modules/karir/karir_page.dart';
import 'package:unishare/app/modules/leaderboard/views/leaderboard_page.dart';
import 'package:unishare/app/modules/milestone/views/milestone_page.dart';
import 'package:unishare/app/modules/notification/notification_screen.dart';

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

class MockKarirService extends Mock implements KarirService {
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
  group('Homescreen test group', () {
    setupFirebaseAuthMocks();

    setUpAll(() async {
      await Firebase.initializeApp();
    });

    testWidgets('Verify the presence of some widgets on the Home Screen',
        (WidgetTester tester) async {
      FlutterError.onError = ignoreOverflowErrors;
      await tester.pumpWidget(const MaterialApp(home: HomeScreen()));

      // Memastikan page pertama yang tampil adalah Dashboard screen
      expect(find.byType(HomeScreen), findsOneWidget);
      expect(find.byType(Dashboard), findsOneWidget);

      // Memastikan text yg ada pada dashboard tampil pada layar
      expect(find.text("Selamat Datang"), findsOneWidget);
      expect(find.text("Milestone"), findsOneWidget);
      expect(find.text("Notifikasi"), findsOneWidget);
      expect(find.text("Beasiswa"), findsAny);
      expect(find.text("Magang"), findsOneWidget);
    });

    testWidgets(
        'Home screen can navigate to KARIR PAGE by tapping navbar icon, and vice versa',
        (WidgetTester tester) async {
      FlutterError.onError = ignoreOverflowErrors;
      await tester.pumpWidget(const MaterialApp(home: HomeScreen()));

      // Verify homepage can navigate to karir page
      await tester.tap(find.byKey(const Key("karir-navbar-button")));
      await tester.pumpAndSettle();
      expect(find.byType(KarirPage), findsOneWidget);
      expect(find.text("Lowongan Kerja"), findsOneWidget);
      expect(find.text("Magang"), findsOneWidget);

      // Verify karir page can navigate back to the home page using the back button
      await tester.tap(find.byType(IconButton).first);
      await tester.pumpAndSettle();
      expect(find.byType(HomeScreen), findsOneWidget);
    });

    testWidgets(
        'Home screen can navigate to ACARA by tapping navbar icon, and vice versa',
        (WidgetTester tester) async {
      FlutterError.onError = ignoreOverflowErrors;
      await tester.pumpWidget(const MaterialApp(home: HomeScreen()));

      // Verify homepage can navigate to acara page
      await tester.tap(find.byKey(const Key("acara-navbar-button")));
      await tester.pumpAndSettle();
      expect(find.byType(AcaraPage), findsOneWidget);
      expect(find.text("Kompetisi"), findsAtLeastNWidgets(1));
      expect(find.byType(SingleChildScrollView), findsOneWidget);

      // Verify acara page can navigate back to the home page using the back button
      await tester.tap(find.byType(IconButton).first);
      await tester.pumpAndSettle();
      expect(find.byType(HomeScreen), findsOneWidget);
    });

    testWidgets(
      // 'Navigation from home screen to specific pages and back'
      'Verify the user can view notifications on their account',
      (WidgetTester tester) async {
        FlutterError.onError = ignoreOverflowErrors;

        // Define a list of maps containing key and dynamic value pairs
        final List<Map<String, dynamic>> navigationTests = [
          {
            'buttonKey': const Key("leaderboard-icon-button"),
            'pageType': LeaderboardPage,
            'pageTitle': "Leaderboard",
          },
          {
            'buttonKey': const Key("notifikasi-icon-button"),
            'pageType': NotificationPage,
            'pageTitle': "Notifikasi",
          },
          {
            'buttonKey': const Key("beasiswa-icon-button"),
            'pageType': BeasiswaScreen,
            'pageTitle': "Beasiswa",
          },
          {
            'buttonKey': const Key("milestone-icon-button"),
            'pageType': MilestonePage,
            'pageTitle': "Milestone",
          },
        ];

        for (final navigationTest in navigationTests) {
          await tester.pumpWidget(const MaterialApp(home: HomeScreen()));

          // Tap the button corresponding to the current test case
          await tester.tap(find.byKey(navigationTest['buttonKey']));
          await tester.pumpAndSettle();
          expect(find.byType(navigationTest['pageType']), findsOneWidget);
          expect(find.text(navigationTest['pageTitle']), findsAny);

          // Navigate back to the home page using the back button
          await tester.tap(find.byType(IconButton).first);
          await tester.pumpAndSettle();

          // Verify that we're back on the home screen
          if (navigationTest['pageType'] != MilestonePage) {
            expect(find.byType(HomeScreen), findsOneWidget);
          }
        }
      },
    );

    testWidgets('Verify _buildBeasiswaList and _buildBeasiswaItem methods',
            (WidgetTester tester) async {
              FlutterError.onError = ignoreOverflowErrors;
          final mockBeasiswaService = MockBeasiswaService();
          final mockSnapshot = MockQuerySnapshot();
          final mockDocumentSnapshots = [
            MockQueryDocumentSnapshot({
              'penyelenggara': 'Penyelenggara 1',
              'judul': 'Beasiswa 1',
              'endDate': Timestamp.fromDate(DateTime(2023, 12, 31)),
            }),
            MockQueryDocumentSnapshot({
              'penyelenggara': 'Penyelenggara 2',
              'judul': 'Beasiswa 2',
              'endDate': Timestamp.fromDate(DateTime(2023, 11, 30)),
            }),
          ];

          mockSnapshot.setDocs(mockDocumentSnapshots);

          when(mockBeasiswaService.getBeasiswas())
              .thenAnswer((_) => Stream.value(mockSnapshot));

          await tester.pumpWidget(
            MaterialApp(
              home: Dashboard(beasiswaService: mockBeasiswaService),
            ),
          );

          await tester.pumpAndSettle();

          expect(find.byType(HomepageCardd), findsNWidgets(2));
          expect(find.text('Beasiswa 1'), findsOneWidget);
          expect(find.text('Beasiswa 2'), findsOneWidget);
        });

    testWidgets('Verify _buildMagangList and _buildMagangItem methods',
            (WidgetTester tester) async {
              FlutterError.onError = ignoreOverflowErrors;
          final mockKarirService = MockKarirService();
          final mockSnapshot = MockQuerySnapshot();
          final mockDocumentSnapshots = [
            MockQueryDocumentSnapshot({
              'penyelenggara': 'Penyelenggara 1',
              'posisi': 'Posisi 1',
              'endDate': Timestamp.fromDate(DateTime(2023, 12, 31)),
            }),
            MockQueryDocumentSnapshot({
              'penyelenggara': 'Penyelenggara 2',
              'posisi': 'Posisi 2',
              'endDate': Timestamp.fromDate(DateTime(2023, 11, 30)),
            }),
          ];

          mockSnapshot.setDocs(mockDocumentSnapshots);

          when(mockKarirService.getDocumentsByKategori('Magang'))
              .thenAnswer((_) => Stream.value(mockSnapshot));

          await tester.pumpWidget(
            MaterialApp(
              home: Dashboard(karirService: mockKarirService),
            ),
          );

          await tester.pumpAndSettle();

          expect(find.byType(HomepageCardd), findsNWidgets(2));
          expect(find.text('Magang Posisi 1'), findsOneWidget);
          expect(find.text('Magang Posisi 2'), findsOneWidget);
        });

  });
}
