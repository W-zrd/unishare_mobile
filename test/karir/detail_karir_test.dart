import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:unishare/app/models/karirmodel.dart';
import 'package:unishare/app/modules/homescreen/home_screen.dart';
import 'package:unishare/app/modules/karir/detail_karir_ril.dart';
import 'package:unishare/app/modules/karir/form_daftar_karir.dart';
import 'package:unishare/app/modules/karir/karir_page.dart';
import 'package:unishare/app/modules/karir/lowongan_kerja.dart';

import '../mock.dart';
import '../test_helper.dart';

void main() {
  group('Detail Karir Test', () {
    setupFirebaseAuthMocks();

    setUpAll(() async {
      await Firebase.initializeApp();
    });

    testWidgets('Test DetailKarirRil widget', (WidgetTester tester) async {
      FlutterError.onError = ignoreOverflowErrors;
      // Create a mock KarirPost object
      final mockKarirPost = KarirPost(
        posisi: 'Test Position',
        penyelenggara: 'Test Organizer',
        lokasi: 'Test Location',
        urlKarir: 'https://example.com',
        img: 'assets/img/test_image.png',
        tema: 'Test Theme',
        kategori: 'Test Category',
        deskripsi: 'Test Description',
        startDate: Timestamp.fromDate(DateTime(2023, 1, 1)),
        endDate: Timestamp.fromDate(DateTime(2023, 12, 31)),
        AnnouncementDate: Timestamp.fromDate(DateTime(2023, 6, 1)),
      );

      // Build the DetailKarirRil widget
      await tester.pumpWidget(
        MaterialApp(
          home: DetailKarirRil(
            karirID: 'test_karir_id',
            karir: mockKarirPost,
          ),
        ),
      );

      // Verify that the widget displays the correct data
      expect(find.text('Test Position'), findsOneWidget);
      expect(find.text('Test Organizer'), findsOneWidget);
      expect(find.text('Registrasi: 12 Agust - 28 Sept 2023'), findsOneWidget);
      expect(find.text('Test Description'), findsOneWidget);

      // Verify that the "Daftar" button is present
      expect(find.text('Daftar'), findsOneWidget);

      // Tap the "Daftar" button and verify navigation
      await tester.tap(find.text('Daftar'));
      await tester.pumpAndSettle();

      // Verify that the DaftarKarir screen is pushed
      expect(find.byType(DaftarKarir), findsOneWidget);
    });

    testWidgets('Test DetailKarirRil back button', (WidgetTester tester) async {
      FlutterError.onError = ignoreOverflowErrors;
      await tester.pumpWidget(
        MaterialApp(
          home: DetailKarirRil(),
        ),
      );
      await tester.tap(find.byIcon(Icons.arrow_back));
      await tester.pumpAndSettle();
      expect(find.byType(KarirPage), findsOneWidget);
    });

    testWidgets('Test Form daftar karir back button', (WidgetTester tester) async {
      FlutterError.onError = ignoreOverflowErrors;
      await tester.pumpWidget(
        MaterialApp(
          home: DetailKarirRil(),
        ),
      );
      await tester.tap(find.byType(ElevatedButton));
      await tester.pumpAndSettle();
      await tester.tap(find.byIcon(Icons.arrow_back));
      await tester.pumpAndSettle();
      expect(find.byType(KarirPage), findsOneWidget);
    });

    testWidgets('Test DaftarKarir widget', (WidgetTester tester) async {
      // Create a mock KarirPost object
      final mockKarirPost = KarirPost(
        posisi: 'Test Position',
        penyelenggara: 'Test Organizer',
        lokasi: 'Test Location',
        urlKarir: 'https://example.com',
        img: 'assets/img/test_image.png',
        tema: 'Test Theme',
        kategori: 'Test Category',
        deskripsi: 'Test Description',
        startDate: Timestamp.fromDate(DateTime(2023, 1, 1)),
        endDate: Timestamp.fromDate(DateTime(2023, 12, 31)),
        AnnouncementDate: Timestamp.fromDate(DateTime(2023, 6, 1)),
      );

      // Build the DaftarKarir widget
      await tester.pumpWidget(
        MaterialApp(
          home: DaftarKarir(karirID: 'test_karir_id'),
          routes: {
            '/home': (context) => const HomeScreen(),
          },
        ),
      );

      // Fill in the form fields
      await tester.enterText(find.byType(TextFormField).at(0), 'John Doe');
      await tester.enterText(
          find.byType(TextFormField).at(1), 'johndoe@example.com');
      await tester.enterText(find.byType(TextFormField).at(2), '1234567890');
      await tester.enterText(
          find.byType(TextFormField).at(3), 'Jl. KTP No. 123');
      await tester.enterText(
          find.byType(TextFormField).at(4), 'Jl. Domisili No. 456');
      await tester.enterText(
          find.byType(TextFormField).at(5), 'https://linkedin.com/in/johndoe');
      await tester.enterText(
          find.byType(TextFormField).at(6), 'Test University');
      await tester.enterText(find.byType(TextFormField).at(7), 'Test Faculty');
      await tester.enterText(find.byType(TextFormField).at(8), 'Test Major');

      await tester.pumpAndSettle();
      print('Form fields filled.');

      // Tap the "Daftar" button
      await tester.ensureVisible(find.text('Daftar'));
      await tester.pumpAndSettle();
      print('Tapping the "Daftar" button...');
      await tester.tap(find.text('Daftar'));
      await tester.pumpAndSettle();

      expect(
          find.text('Please select CV and Motivation Letter'), findsOneWidget);
      expect(find.byType(DaftarKarir), findsOneWidget);
    });
  });
}
