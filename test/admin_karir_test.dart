import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:unishare/app/modules/admin/karir/karirpostadmin.dart';
import 'package:unishare/app/modules/admin/karir/makekarirpost.dart';

import 'mock.dart';
import 'test_helper.dart';

void main() {
  group('Admin karir test group', () {
    setupFirebaseAuthMocks();

    setUpAll(() async {
      await Firebase.initializeApp();
    });

    testWidgets('Verify the presence of widgets', (WidgetTester tester) async {
      FlutterError.onError = ignoreOverflowErrors;
      await tester.pumpWidget(MaterialApp(home: KarirAdmin()));

      expect(find.widgetWithText(AppBar, 'Karir'), findsOneWidget);
      expect(find.byType(Expanded), findsAny);
    });

    testWidgets('Verify the behavior of FloatingActionButton',
        (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: KarirAdmin()));

      await tester.tap(find.byType(FloatingActionButton));
      await tester.pumpAndSettle();

      expect(find.byType(MakeKarirPost), findsOneWidget);
    });
  });
}
