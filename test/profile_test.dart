import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:unishare/app/modules/profil/views/profil_page.dart';

import 'mock.dart';
import 'test_helper.dart';

void main() {
  group('Profile page test group', () {
    setupFirebaseAuthMocks();

    setUpAll(() async {
      await Firebase.initializeApp();
    });

    testWidgets('Verify the presence of widgets', (WidgetTester tester) async {
      FlutterError.onError = ignoreOverflowErrors;
      await tester.pumpWidget(
        MaterialApp(
          home: ProfilPage(
          ),
        ),
      );

      expect(find.widgetWithText(AppBar, 'Profil'), findsOneWidget);
      expect(find.byType(TextFormField), findsExactly(4));
      expect(find.byType(CircleAvatar), findsOneWidget);
    });
  });
}
