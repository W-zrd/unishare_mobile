import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:unishare/app/modules/jadwal/jadwal.dart';
import 'package:unishare/app/modules/jadwal/jadwal_page.dart';
import 'package:unishare/app/modules/jadwal/to_do_list.dart';
import 'package:unishare/app/widgets/card/to_do_list_card.dart';
import 'package:unishare/app/widgets/chart/chart.dart';
import 'package:unishare/app/widgets/chart/chart_explanation.dart';
import 'package:unishare/app/widgets/date/date_button.dart';

import 'mock.dart';
import 'test_helper.dart';

void main() {
  group('Jadwal test group', () {
    setupFirebaseAuthMocks();

    setUpAll(() async {
      await Firebase.initializeApp();
    });

    // testWidgets('Verify the presence of widgets on the Jadwal Page',
    //     (WidgetTester tester) async {
    //   FlutterError.onError = ignoreOverflowErrors;
    //   await tester.pumpWidget(const MaterialApp(home: JadwalMain()));
    //
    //   expect(find.byType(JadwalPage), findsOneWidget);
    //   expect(find.byType(TanggalButton), findsExactly(7));
    //   expect(find.byType(SingleChildScrollView), findsOneWidget);
    // });
    //
    // testWidgets('Verify To-do List functionality works properly',
    //     (WidgetTester tester) async {
    //   FlutterError.onError = ignoreOverflowErrors;
    //   await tester.pumpWidget(const MaterialApp(home: JadwalMain()));
    //
    //   await tester.tap(find.widgetWithText(Tab, "To-do List"));
    //   await tester.pumpAndSettle();
    //   expect(find.byType(ToDoList), findsOneWidget);
    //   expect(find.byType(PieChartSample2), findsOneWidget);
    //   expect(find.byType(ChartExplanation), findsExactly(3));
    //
    //   if (tester.widgetList(find.byType(ToDoListCard)).isNotEmpty){
    //     expect(find.byType(ToDoListCard), findsAtLeastNWidgets(1));
    //
    //     await tester.tap(find.byType(Checkbox).first);
    //     await tester.pumpAndSettle();
    //     Checkbox checkboxWidget = tester.widget(find.byType(Checkbox).first);
    //     expect(checkboxWidget.value, true);
    //   }
    // });

  });
}
