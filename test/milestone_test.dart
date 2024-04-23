import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
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
        'Verify the presence of widgets on the Milestone Page',
            (WidgetTester tester) async {
          FlutterError.onError = ignoreOverflowErrors;
          await tester.pumpWidget(const MaterialApp(home:MilestonePage()));

          expect(find.byType(IconButton), findsAtLeastNWidgets(1));
          expect(find.text("Milestone"), findsAtLeastNWidgets(1));
          expect(find.text("List Milestone"), findsOneWidget);

          expect(find.byType(MilestoneCard), findsAny);
          expect(find.byType(PencapaianCard), findsExactly(2));
        });
  });
}
