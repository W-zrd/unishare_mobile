import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:unishare/app/modules/karir/detail_karir.dart';
import 'package:unishare/app/widgets/card/description_card.dart';
import 'package:unishare/app/widgets/card/detail_top_card.dart';
import 'package:unishare/app/widgets/card/regulation_card.dart';

void main() {
  group('DetailKarir Widget Tests', () {
    testWidgets('DetailKarir widget renders correctly', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(
        home: DetailKarir(),
      ));

      expect(find.text('Detail Karir'), findsOneWidget);
      expect(find.byType(CardDetailTop), findsOneWidget);
      expect(find.byType(TabBar), findsOneWidget);
      expect(find.byType(TabBarView), findsOneWidget);
    });

    testWidgets('DetailKarir widget displays correct tab labels', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(
        home: DetailKarir(),
      ));

      expect(find.text('Deskripsi'), findsOneWidget);
      expect(find.text('Persyaratan'), findsOneWidget);
    });

    testWidgets('DetailKarir widget displays description card', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(
        home: DetailKarir(),
      ));

      expect(find.byType(DescriptionCard), findsOneWidget);
      expect(find.text('Virtual Talent Indonesia Inc. telah secara aktif terlibat dalam percetakan. Kami membutuhkan staf keuangan untuk mendukung operasi penjualan kami yang berkembang pesat. Kandidat yang terpilih dapat menjalani on-the-job training dengan Manajer Keuangan.'), findsOneWidget);
    });

    testWidgets('DetailKarir widget displays regulation card', (WidgetTester tester) async {
    // Pump the widget into the widget tree
    await tester.pumpWidget(const MaterialApp(
      home: DetailKarir(),
    ));

    // Allow for any asynchronous operations to complete
    await tester.pumpAndSettle();

    // Tap the 'Persyaratan' tab
    await tester.tap(find.text('Persyaratan'));
    await tester.pumpAndSettle();

    // Verify that the RegulationCard is found in the widget tree
    expect(find.byType(RegulationCard), findsOneWidget);
  });;
  });
}