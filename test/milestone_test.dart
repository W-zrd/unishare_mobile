import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:unishare/app/modules/homescreen/home_screen.dart';
import 'package:unishare/app/modules/milestone/views/milestone_page.dart';
import 'package:unishare/app/widgets/milestone_card.dart';
import 'package:unishare/app/widgets/pencapaian_card.dart';

import 'mock.dart';
import 'test_helper.dart';

void main() {
  group('Milestone test group', () {
    setupFirebaseAuthMocks();

    setUpAll(() async {
      await Firebase.initializeApp();
    });

    testWidgets(
        'Verify the user can view their achieved milestones',
            (WidgetTester tester) async {
          FlutterError.onError = ignoreOverflowErrors;
          await tester.pumpWidget(const MaterialApp(home:MilestonePage()));

          expect(find.byType(IconButton), findsAtLeastNWidgets(1));
          expect(find.text("Milestone"), findsAtLeastNWidgets(1));
          expect(find.text("List Milestone"), findsOneWidget);

          expect(find.byType(MilestoneCard), findsAny);
          expect(find.byType(PencapaianCard), findsExactly(2));

          await tester.tap(find.byKey(Key('back-button')));
          await tester.pumpAndSettle();
          expect(find.byType(HomeScreen), findsOneWidget);
        });
  });
}
