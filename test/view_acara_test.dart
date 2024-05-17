import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:unishare/app/modules/acara/view/acara_all.dart';
import 'package:unishare/app/modules/acara/view/acara_page.dart';
import 'package:unishare/app/modules/acara/view/kompetisi.dart';
import 'package:unishare/app/modules/acara/view/seminar.dart';
import 'package:unishare/app/modules/acara/view/workshop.dart';
import 'package:unishare/app/widgets/card/description_card.dart';
import 'package:unishare/app/widgets/card/post_card.dart';
import 'package:unishare/app/widgets/card/regulation_card.dart';

import 'mock.dart';

void main() {
  group('Acara page test group', () {
    setupFirebaseAuthMocks();

    setUpAll(() async {
      await Firebase.initializeApp();
    });

    testWidgets('Verify acara page can be loaded and rendered correctly',
            (WidgetTester tester) async {
          await tester.pumpWidget(const MaterialApp(home: AcaraPage()));

          expect(find.byType(ElevatedButton), findsExactly(4));
          expect(find.byType(AllAcaraPage), findsOneWidget);

          if (tester.widgetList(find.byType(PostCard)).isNotEmpty) {
            expect(find.byType(PostCard), findsAny);
          }
        });

    testWidgets(
        'Verify post card on each category can navigates to detail acara, and "Persyaratan" tab on detail acara can be pressed',
            (WidgetTester tester) async {
          await tester.pumpWidget(const MaterialApp(home: AcaraPage()));

          final List<Map<String, dynamic>> kategori = [
            {'key': 'all-category', 'page': AllAcaraPage},
            {'key': 'kompetisi-category', 'page': KompetisiPage},
            {'key': 'workshop-category', 'page': WorkshopPage},
            {'key': 'seminar-category', 'page': SeminarPage},
          ];

          for (final category in kategori) {
            await tester.tap(find.byKey(Key(category['key'])));
            await tester.pumpAndSettle();
            expect(find.byType(category['page']), findsOneWidget);
            expect(find.byType(ListView), findsOneWidget);

            if (tester.widgetList(find.byType(PostCard)).isNotEmpty) {
              await tester.tap(find.byType(PostCard).first);
              await tester.pumpAndSettle();
              expect(find.byType(AllAcaraPage), findsNothing);

              await tester.tap(find.widgetWithText(Tab, "Persyaratan"));
              await tester.pumpAndSettle();
              expect(find.byType(RegulationCard), findsOneWidget);
              expect(find.byType(DescriptionCard), findsNothing);

              await tester.tap(find.byType(IconButton).first);
              await tester.pumpAndSettle();
              expect(find.byType(category['page']), findsOneWidget);
            }
          }
        });
  });
}
