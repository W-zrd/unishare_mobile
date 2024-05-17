import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'mock.dart';
import 'test_helper.dart';

// w333zard

void main() {
  group('Judul test group (ex: Admin dashboard test group)', () {
    setupFirebaseAuthMocks();

    setUpAll(() async {
      await Firebase.initializeApp();
    });

    testWidgets(
        'Judul test suite (ex: verify submit button can navigates to the homepage)',
        (WidgetTester tester) async {
      FlutterError.onError = ignoreOverflowErrors;

      // UNCOMMENT THIS
      // await tester.pumpWidget(const MaterialApp(home: ));

    });

  });
}
