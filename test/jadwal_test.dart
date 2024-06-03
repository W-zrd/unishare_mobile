import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:unishare/app/controller/karir_submission_controller.dart';
import 'package:unishare/app/modules/jadwal/jadwal.dart';
import 'package:unishare/app/modules/jadwal/jadwal_mainpage.dart';
import 'package:unishare/app/modules/jadwal/to_do_list.dart';
import 'package:unishare/app/widgets/card/to_do_list_card.dart';
import 'package:unishare/app/widgets/chart/chart.dart';
import 'package:unishare/app/widgets/chart/chart_explanation.dart';
import 'package:unishare/app/widgets/date/date_button.dart';

import 'mock.dart';
import 'test_helper.dart';

class MockUser extends Mock implements User {
  @override
  String get uid => 'mock_user_uid';
}

class MockFirebaseAuth extends Mock implements FirebaseAuth {
  @override
  User? get currentUser => MockUser();
}

class MockKarirSubmissionService extends Mock implements KarirSubmissionService {
  @override
  Stream<QuerySnapshot> getDocumentsByField(String? userid) {
    if (userid == null) {
      return Stream.value(MockQuerySnapshot());
    }
    return Stream.value(MockQuerySnapshot());
  }
}

class MockQuerySnapshot extends Mock implements QuerySnapshot {
  @override
  List<QueryDocumentSnapshot> get docs => [
    MockQueryDocumentSnapshot(),
  ];
}

class MockQueryDocumentSnapshot extends Mock implements QueryDocumentSnapshot {
  @override
  Map<String, dynamic> data() {
    return {
      'karirID': 'mock_karir_id',
    };
  }
}

void main() {
  group('Jadwal test group', () {
    setupFirebaseAuthMocks();

    setUpAll(() async {
      await Firebase.initializeApp();
    });

    testWidgets('Verify JadwalMain widget renders correctly', (WidgetTester tester) async {
      FlutterError.onError = ignoreOverflowErrors;
      await tester.pumpWidget(MaterialApp(home: JadwalMain()));

      expect(find.text('Jadwal'), findsNWidgets(2));
      expect(find.byType(TabBar), findsOneWidget);
      expect(find.text('To-do List'), findsOneWidget);
      expect(find.byType(TabBarView), findsOneWidget);
    });

    // testWidgets('Verify JadwalPage widget renders correctly when user is logged in', (WidgetTester tester) async {
    //   final mockFirebaseAuth = MockFirebaseAuth();
    //   final mockKarirSubmissionService = MockKarirSubmissionService();
    //
    //   when(mockFirebaseAuth.currentUser).thenReturn(MockUser());
    //   when(mockKarirSubmissionService.getDocumentsByField(any)).thenAnswer((_) => Stream.value(MockQuerySnapshot()));
    //
    //   await tester.pumpWidget(
    //     MaterialApp(
    //       home: JadwalPage(),
    //     ),
    //   );
    //
    //   expect(find.text('Berikut adalah jadwalmu'), findsOneWidget);
    //   expect(find.byType(ListView), findsOneWidget);
    // });
    //
    // testWidgets('Verify JadwalPage widget shows "No user logged in" when user is not logged in', (WidgetTester tester) async {
    //   final mockFirebaseAuth = MockFirebaseAuth();
    //   when(mockFirebaseAuth.currentUser).thenReturn(null);
    //
    //   await tester.pumpWidget(
    //     MaterialApp(
    //       home: JadwalPage(),
    //     ),
    //   );
    //
    //   expect(find.text('No user logged in'), findsOneWidget);
    // });

    // Add more test cases as needed
  });
}