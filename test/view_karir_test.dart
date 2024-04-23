import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:unishare/app/modules/karir/views/karir_page.dart';
import 'package:unishare/app/modules/karir/views/lowongan_kerja.dart';
import 'package:unishare/app/modules/karir/views/magang.dart';
import 'package:unishare/app/widgets/card/description_card.dart';
import 'package:unishare/app/widgets/card/post_card.dart';
import 'package:unishare/app/widgets/card/regulation_card.dart';

import 'mock.dart';

void main() {
  group('Karir page test group', () {
    setupFirebaseAuthMocks();

    setUpAll(() async {
      await Firebase.initializeApp();
    });

    testWidgets('Verify Karir page can be loaded and rendered correctly',
        (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: KarirPage()));

      expect(find.widgetWithText(Tab, "Lowongan Kerja"), findsOneWidget);
      expect(find.widgetWithText(Tab, "Magang"), findsOneWidget);
      expect(find.byType(LowonganKerjaPage), findsOneWidget);

      if (tester.widgetList(find.byType(PostCard)).isNotEmpty) {
        expect(find.byType(PostCard), findsAny);
      }
    });

    testWidgets(
        'Verify post card on each category can navigates to detail karir, and "Persyaratan" tab on detail karir can be pressed',
        (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: KarirPage()));

      if (tester.widgetList(find.byType(PostCard)).isNotEmpty) {
        await tester.tap(find.widgetWithText(Tab, "Magang"));
        await tester.tap(find.byType(PostCard).first);
        await tester.pumpAndSettle();
        expect(find.byType(MagangPage), findsNothing);

        await tester.tap(find.widgetWithText(Tab, "Persyaratan"));
        await tester.pumpAndSettle();
        expect(find.byType(RegulationCard), findsOneWidget);
        expect(find.byType(DescriptionCard), findsNothing);

        await tester.tap(find.byType(IconButton).first);
        await tester.pumpAndSettle();
        expect(find.byType(MagangPage), findsOneWidget);
        expect(find.byType(KarirPage), findsOneWidget);

        await tester.tap(find.widgetWithText(Tab, "Lowongan Kerja"));
        await tester.tap(find.byType(PostCard).first);
        await tester.pumpAndSettle();
        expect(find.byType(LowonganKerjaPage), findsNothing);
      }
    });
  });
}
