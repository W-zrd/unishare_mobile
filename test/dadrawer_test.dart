import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:unishare/app/modules/admin/acara/make_acara_post_screen.dart';
import 'package:unishare/app/modules/admin/beasiswa/beasiswa_post_admin.dart';
import 'package:unishare/app/modules/admin/dashboard/views/dashboard_admin.dart';
import 'package:unishare/app/widgets/dadrawer.dart';

import 'mock.dart';
import 'test_helper.dart';

void main() {
  testDrawerHeader();
  testDashboardListTile();
  testKarirListTile();
  testAcaraListTile();
  testBeasiswaListTile();
  testLogoutListTile();
  testAcaraListTileTap();
  testBeasiswaButtonTap();
}

void testDrawerHeader() {
  testWidgets('Verify the existence of the DrawerHeader',
          (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: DaDrawer(),
            ),
          ),
        );
        expect(find.byType(DrawerHeader), findsOneWidget);
      });
}

void testDashboardListTile() {
  testWidgets('Verify the existence of the ListTile for Dashboard',
          (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: DaDrawer(),
            ),
          ),
        );
        expect(find.widgetWithText(ListTile, 'Dashboard'), findsOneWidget);
      });
}

void testKarirListTile() {
  testWidgets('Verify the existence of the ListTile for Karir',
          (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: DaDrawer(),
            ),
          ),
        );
        expect(find.widgetWithText(ListTile, 'Karir'), findsOneWidget);
      });
}

void testAcaraListTile() {
  testWidgets('Verify the existence of the ListTile for Acara',
          (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: DaDrawer(),
            ),
          ),
        );
        expect(find.widgetWithText(ListTile, 'Acara'), findsOneWidget);
      });
}

void testBeasiswaListTile() {
  testWidgets('Verify the existence of the ListTile for Beasiswa',
          (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: DaDrawer(),
            ),
          ),
        );
        expect(find.widgetWithText(ListTile, 'Beasiswa'), findsOneWidget);
      });
}

void testLogoutListTile() {
  testWidgets('Verify the existence of the ListTile for Logout',
          (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: DaDrawer(),
            ),
          ),
        );
        expect(find.widgetWithText(ListTile, 'L O G O U T'), findsOneWidget);
      });
}

void testAcaraListTileTap() {
  testWidgets('Tap on the ListTile for Acara', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: DaDrawer(),
        ),
      ),
    );
    await tester.tap(find.widgetWithText(ListTile, 'Acara'));
    await tester.pumpAndSettle();

    expect(find.byType(MakeAcaraPost), findsOneWidget);
  });
}

void testBeasiswaButtonTap() {
  testWidgets('Tap on Beasiswa Button', (WidgetTester tester) async {
    // FlutterError.onError = ignoreOverflowErrors;

    setupFirebaseAuthMocks();

    await Firebase.initializeApp();

    await tester.pumpWidget(MaterialApp(home: DaDrawer()));
    // await tester.pumpWidget(const DaDrawer());
    print('country roads 1');
    await tester.pumpAndSettle();
    print('country roads 2');
    await tester.tap(find.byKey(Key('beasiswa-button')));
    print('country roads 3');
    await tester.pumpAndSettle();
    print('country roads 4');
    expect(find.byType(BeasiswaAdmin), findsOneWidget);

    //  await tester.tap(find.byKey(navigationTest['buttonKey']));
    //  await tester.pumpAndSettle();
    //  expect(find.byType(navigationTest['pageType']), findsOneWidget);
    //  expect(find.text(navigationTest['pageTitle']), findsAny); haikal
  });
}